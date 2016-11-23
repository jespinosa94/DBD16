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
create or replace trigger precios_cat
after insert or update on pvptemporada
for each row
begin
  if(:new.psa>:new.pad and :new.psa is not null and :new.pad is not null) then
    raise_application_error(-20601, 'El valor pSA: ' || :new.psa || ' es mayor que el precio de pAD');
  else if(:new.pad>:new.pmp and :new.pad is not null and :new.pmp is not null) then
    raise_application_error(-20601, 'El valor pAD: ' || :new.pad || ' es mayor que el precio de pMP');
  else if(:new.pmp>:new.ppc and :new.pmp is not null and :new.ppc is not null) then
    raise_application_error(-20601, 'El valor pMP: ' || :new.pmp || ' es mayor que el precio de pPC');
end;

delete from pvptemporada where categoria='S' and temporada='BAJA';
insert into pvptemporada values('S', 'BAJA', 200, 100, 50, 60);

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
--Las habitaciones tipo SUITE sólo están en la quinta planta.
create or replace trigger s11e2
after insert or update on habitacion
for each row
begin
  if(:new.categoria='S' and :new.piso!=5) then
    raise_application_error(-20601, 'Las habitaciones de tipo Suite solo pueden estar en la quinta planta');
  end if;
end;

insert into habitacion values(10, 'S', 21, 5);
insert into habitacion (numero, categoria) values(11, 'S');

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
--comprobar que funciona con varios insert
create or replace trigger s11e3
after insert or modify on calendreservas
for each row
declare aux habitacion.categoria%type;
begin
  select categoria into aux from habitacion join calendreservas where habitacion=numero;
  if(aux='I') then
    if(:new.camasup='SI') then
      raise_application_error(-20601, 'Las habitaciones individuales no pueden tener cama supletoria');
    end if;
  end if;
end;

insert into calendreservas (habitacion, fecha, camasup) values(4, '23-11-2016', 'no'); 
  
  
  
  
  