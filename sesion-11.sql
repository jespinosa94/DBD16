-------------------------------------------------Procedimiento ESCRIBIR--------------------------------------------------------------------
--
create or replace procedure escribir(auxcad in varchar) is
begin
dbms_output.enable;
dbms_output.put_line(auxcad);
end;

set serveroutput on format;

-------------------------------------------------Ejercicio 1--------------------------------------------------------------------
--
create or replace trigger pr11ej1 after update or insert on pvptemporada
for each row 
begin
  if (:new.psA>:new.pAD or :new.pSA>:new.pMP or :new.pSA>:new.pPC) then
    raise_application_error(-20601, 'El precio de SA no es inferior a alguno de los otros');
  end if;
  if (:new.pAD>:newpMP or :new.pAD>:new.pPC or :new.pSA>:new.pPC) then
    raise_application_error(-2601, 'oli');
  end if;
  if (:new.pMP>:new.pPC) then
    raise_application_error(-20601, 'oli');
  end if;  
end;  
  
-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
create or replace trigger pr11ej2 
after insert or update of categoria, piso on habitacion
for each row
begin
  if (:new.categoria='S' and :new.piso!=5) then
    raise_application_error(-20601, 'oli');
  end if;
end;  
  
  
-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
create or replace trigger pr11ej3
after insert or update on calendreservas
for each row
declare
categoriaHab varchar(2):=null;
begin
  select categoria into categoriaHab from habitacion where :new.habitacion=numero;
  if(categoriaHab='I' and :new.camasup='S') then 
    raise_application_error(-20601, 'oli');
  end if;
end;

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
create or replace trigger pr11ej4
after insert or update
on cita
for each row
declare
  total number(1);
  auxempleado empleado.nombre%type;
auxtrata tratamiento.observaciones%type;
begin
  select count(*) into total from realizar
  where :new.tratamiento=tratamiento and :new.empleado=empleado;
  
  if(total=0) then
    raise_application_error(-20601,'El empleado ' || :new.empleado || ' no ' || :new.tratamiento);
  end if;
end;  

-------------------------------------------------Ejercicio 5--------------------------------------------------------------------
create table auxlimpieza(niflimpieza char(9), mes char(7), total number(2));

create or replace trigger pr11ej5_1
before insert or update on calendario
begin
  delete from auxlimpieza;
  insert into auxlimpieza
    select emplimpieza, to_char(fecha, 'MM-yyyy'), count(*) from calendario
    where emplimpieza is not null
    group by emplimpieza, to_char(fecha, 'MM-yyyy');
end;    

create or replace trigger pr11ej5_2
after insert or update on calendario
for each row
declare
  cuantos number(2);
  auxnombre empleado.nombre%type;
begin
  select total into cuantos
  from auxlimpieza where niflimpieza=:new.emplimpieza and mes=to_char(:new.fecha, 'MM-yyyy');
  
  if cuantos>=5 then
    select nombre into auxnombre from empleado where nif=:new.emplimpieza;
    escribir(auxnombre || ' ya esta bastante cargadito ehh....');
  end if;
  exception
    when no_data_found then null;
end;    

















