-------------------------------------------------Procedimiento ESCRIBIR--------------------------------------------------------------------
--
create or replace procedure escribir(auxcad in varchar) is
begin
dbms_output.enable;
dbms_output.put_line(auxcad);
end;

set serveroutput on format;

-- Sentencias para crear 5 tablas, debes crear las 2 restantes

create table cliente14( 
nif char(9) constraint cpcliente14 primary key, nombre varchar(40), telefono varchar(14), email varchar(50));

create table tipo14(
codtipo number(3) constraint cptipo14 primary key, comentario varchar(30), descripcion varchar(50), tarifadiaria number(3));

create table calendario14(fecha date constraint cpcalendario14 primary key);

create table material14(codigo char(5) constraint cpmaterial14 primary key, estado varchar(10), tipo number(3));

create table proveedor14(nif char(9) constraint proveedor14 primary key, nombre varchar(40), 
telefono varchar(14), email varchar(50));

--Ejercicio 1
set serveroutput on format;

alter table material14
modify estado constraint ckEstado14 check (estado in('NORMAL', 'PESIMO', 'GASTADO', 'OPTIMO'));

--Ejercicio 2
alter table cliente 
modify telefono not null;

--Ejercicio 3
create or replace function pr14ej3(p_cod material14.codigo) return number is
auxtarifa tipo14.tarifadiaria%type;
begin
  select tarifadiaria into auxtarifa from tipo join material on codtipo=tipo where p_cod=codigo;
  return(auxtarifa);
  
  exception
  when no_data_found then escribir('No existe el material') return null;
end;  

--Ejercicio 4
create or replace trigger pr14ej4
after update of estado on material
for each row
declare
  auxcodigo
  auxdescripcion
begin
  if(:old.estado='optimo' and :new.estado='pesimo) then
    select codigo into auxcodigo from material where codigo=:new.codigo;
    select descripcion from tipo where codtipo=:new.tipo;
    escribir('El material ' || auxcodigo || 'que es ' || auxdescripcion || 'pripimini');
  end if;
end;  

--Ejercicio 5
create or replace procedure comprobar(p_material char, p_fecha date) is
cursor c1 is select codigo, estado from material14
where estado!='pesimo' and tipo=(select tipo from material14 where codigo=p_material);
AUXESTADO MATERIAL14.ESTADO%TYPE;
AUXTIPO MATERIAL14.TIPO%TYPE;
ALQUILADO NUMBER(1);
AUX NUMBER(1);
LISTA NUMBER(5);
DEMANDADO EXCEPTION;

begin
  select estado, tipo into auxestado, auxtipo from material14 where codigo=p_material;
  
  if(auxestado!='pesimo') then
    select count(*) into alquilado from alquilar14 where material=p_material and fecha=p_fecha;
    if(alquilado=0) then escribir('se puede reservar');
    else
      lista:=0;
      for rc1 in c1 loop
        select count(*) into aux from alquilar14 where fecha=p_fecha and material=rc1.codigo;
        if(aux=0) then lista=lista+1; escribir(rc1.codigo, rc1.estado); 
        end if;
      end loop;
      if(lista=0) then 
        raise demandado;
      end if;
    end if;
  end if;
  when no_data_found then escribir('no existe el material');
  when demandado then 
    escribir('Sin disponibilidad');
    update tipo14 set comentario = 'MUY DEMANDADO' where codtipo=auxtipo;
end;  

--Ejercicio6
create or replace procedure revisar is
cursor pesimos is select material14.codigo codmat, descripcion from material14, tipo14 where material14.codigo=tipo and upper(estado)='PESIMO'; -- lo de upper no hace falta
auxmaterial material14.codigo%type:=NULL;
cursor alquileresborrados is select  nombre, telefono, fecha from alquilar14, cliente14 where nif=cliente and material=auxmaterial;
total_pesimos number(6):=0;
todos_ok exception;

BEGIN
select count(*) into total_pesimos from material14 where upper(estado)= 'PESIMO';
if total_pesimos=0 then raise todos_ok; end if;

escribir('Se van a borrar los siguientes materiales por mal estado');

for matpesimo in pesimos loop
escribir('MATERIAL: '||matpesimo.codmat||' que es '||matpesimo.descripcion||' retirado.');
auxmaterial:=matpesimo.codmat;

-- select count(*) into total_pesimos from alquilar14 where material=auxmaterial; No lo pide enunciado. 
-- if total_pesimos = 0 then                                                      Queda mejor, por si no tiene alquileres
  escribir('Avisad a:');

  for cli in alquileresborrados loop
--   if cli.fecha > sysdate then                         No lo pide el enunciado. Aqu? se filtra si la fecha de alquiler ya pas? y no es necesario avisar.
   escribir('     '||cli.nombre||'     '||cli.telefono);
--   end if;
  end loop;
  
-- end if;
end loop;
delete from alquilar14 where material in (select codigo from material14 where upper(estado)='PESIMO');

EXCEPTION
when todos_ok then
escribir('No hay material para retirar');

END;

--Ejercicio 7
create or replace
TRIGGER EJERCICIO6
AFTER INSERT ON SUMINISTRAR14
FOR EACH ROW
DECLARE 
AUXTARIFADIARIA TIPO14.TARIFADIARIA%TYPE;
BEGIN
 SELECT TARIFADIARIA INTO AUXTARIFADIARIA FROM TIPO14 WHERE CODTIPO=:NEW.TIPO;
 IF (:NEW.PRECIO>200*AUXTARIFADIARIA)
 THEN
  RAISE_APPLICATION_ERROR(-20100,'Precio muy elevado. No considerarlo');
 ELSE
  IF (:NEW.PRECIO<100*AUXTARIFADIARIA)
  THEN
    ESCRIBIR(:NEW.PROVEEDOR||' nos permite reducir la tarifa de '||:NEW.TIPO);
    UPDATE TIPO14 SET TARIFADIARIA=0.9*TARIFADIARIA WHERE CODTIPO=:NEW.TIPO;
  END IF;
 END IF;
END;
  






















