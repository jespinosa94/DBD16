-------------------------------------------------Procedimiento ESCRIBIR--------------------------------------------------------------------
--
create or replace procedure escribir(auxcad in varchar) is
begin
dbms_output.enable;
dbms_output.put_line(auxcad);
end;

set serveroutput on format;

-------------------------------------------------Ejercicio 1--------------------------------------------------------------------
create or replace trigger pr12ej1
before insert or update on sustninos
for each row
begin
  if(:new.activ1=:new.activ2) then
    raise_application_error(-20601, 'oli');
  end if;
end;  

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
create or replace trigger pr12ej2
before insert or update of supmin on categoria
for each row
begin
  if(:new.supmin>=:new.supmax) then 
    raise_application_error(-20601, 'oli');
  end if;
end;  

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
create or replace trigger pr12ej3
before insert
on horario
for each row
declare total number(2):=0;
auxdescri actividad.descripcion%type;
begin
  select count(distinct actividad) into total from horario where fecha=:new.fecha;
  if(total>=4) then
    select descripcion into auxdescri from actividad where :new.actividad=codigo;
    raise_application_error(-20601, 'oli');
  end if;
end;  

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
create or replace trigger pr12ej4
before insert on calendreservas
for each row
declare 
  auxcategoria habitacion.categoria%type;
  vnif cliente.nif%type;
  cursor otras_res is
  select * from reserva join calendreservas on reserva=codigo where cliente=vnif and fecha=:new.fecha;
begin
  select cliente into vnif from reserva where codigo=:new.reserva;
  
  for reserva in otras_res loop
    select categoria into auxcategoria from habitacion where numero=res.habitacion;
    escribir('habitaci?n '||res.habitacion||' categoria '||auxcategoria||' alimentacion '||res.alimentacion||' cama '||res.camasup);
  end loop;
end;  
  
-------------------------------------------------Ejercicio 5--------------------------------------------------------------------
create table citas_diarias(nif char(9), fecha date, total number(1), constraint pk_citas_diarias primary key(nif, fecha);

create or replace trigger pr12ej5
after insert or delete or update on cita
for each row
declare
  aux number(1):=0;
begin
  select count(*) into aux from citas_diarias 
  where nif=:new.empleado and fecha=:new.fecha;
  
  if inserting or updating then
    if(aux=0) then 
      insert into citas_diarias values(:new.empleado, :new.fecha, 1);
    else
      update citas_diarias set total=total+1 where nif=:new.empleado and fecha=:new.fecha;
    end if;
  end if;
  if deleting or updating then
    update citas_diarias set total = total-1 where nif=:old.empleado and fecha=:old.fecha;
  end if;
end;  
















  
  
  
  
  
  
  
  
  