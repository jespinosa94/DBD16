-------------------------------------------------Procedimiento ESCRIBIR--------------------------------------------------------------------
--
create or replace procedure escribir(auxcad in varchar) is
begin
dbms_output.enable;
dbms_output.put_line(auxcad);
end;

-------------------------------------------------Ejercicio 0--------------------------------------------------------------------
--
CREATE TABLE SERVICIO(
codigo char(4) constraint cp_servicio primary key,
 descripcion varchar(30),
 precio number(5,2));

CREATE TABLE CLIENTE(
nif char(9) constraint cp_cliente primary key,
nombre varchar(40) not null,
telefono  char(11) not null,
localidad varchar(40),
provincia varchar(30),
pais varchar(30));

CREATE TABLE RESERVA(
codigo number(6) constraint cp_reserva primary key,
cliente char(9) references CLIENTE);

CREATE TABLE CALENDRESERVAS(
habitacion number(3) constraint fk_calendreservas_habitacion references HABITACION,
fecha date constraint calendreservas_calendario references CALENDARIO,
camasup char(2),
reserva number(6) constraint fk_calendreservas_reserva references reserva,
constraint cp_calendreservas primary key(habitacion, fecha));



CREATE TABLE CONSUMIR(
habitación number(3),
fecha date,
servicio char(4) constraint fk_consumir_servicio references servicio,
cantidad number(2),
constraint  fk_consumir_calendreservas foreign key(habitación, fecha)  references calendreservas,
constraint pk_consumir primary key(habitación, fecha, servicio));

CREATE TABLE EMPLEADO(
nif char(9) constraint cp_empleado primary key,
nombre varchar(40),
dirección varchar(30),
población varchar(30),
telefono char(9),
estudios  varchar(50));


CREATE TABLE EMPANIMACION(
nif char(9) constraint fk_empanimacion_empleado references empleado 
constraint pk_empanimacion primary key);

CREATE TABLE EMPSERVICIOS(
nif char(9) constraint fk_empservicios_empleado references empleado 
constraint pk_empservicios primary key);

CREATE TABLE EMPLIMPIEZA(
nif char(9) constraint fk_emplimpieza_empleado references empleado 
constraint pk_emplimpieza primary key);

CREATE TABLE EMPRESTAURANTE(
nif char(9) constraint fk_emprestaurante_empleado references empleado 
constraint pk_emprestaurante primary key);

CREATE TABLE EMPRECEPCION(
nif char(9) constraint fk_emprecepcion_empleado references empleado 
constraint pk_emprecepcion primary key);

--Habrá que controlar que la generalización de EMPLEADO es TOTAL y DISJUNTA.

CREATE TABLE AGENCIAVIAJES(
cif char(9) constraint pk_agenciaviajes primary key,
nombre varchar(30),
telefono char(9));

CREATE TABLE RESAGENCIA(
reserva number(6) constraint fk_resagencia_reserva references reserva
constraint pk_resagencia primary key,
agencia char(9) constraint fk_resagencia_agencia references agenciaviajes not null,
emprecepcion char(9) constraint fk_resagencia_emprecepcion  references emprecepcion not null);

CREATE TABLE RESTELEFONO(
reserva number(6) constraint fk_restelefono_reserva references reserva 
constraint pk_restelefono primary key,
emprecepcion char(9) constraint fk_restelefono_emprecepcion references emprecepcion  not null);

CREATE TABLE RESHOTEL(
reserva number(6)  constraint fk_reshotel_reserva references reserva
 constraint pk_reshotel primary key,
emprecepcion char(9) constraint fk_reshotel_emprecepcion references emprecepcion  not null);

CREATE TABLE RESINTERNET (
reserva number(6)  constraint fk_resinternet_reserva references reserva
 constraint pk_resinternet primary key,
localizador number(6)  not null);

--Habrá que controlar que la generalización de EMPLEADO es TOTAL y DISJUNTA.

CREATE TABLE TRATAMIENTO(
codigo char(5) constraint pk_tratamiento primary key,
observaciones varchar(50),
precio number(3) not null);

CREATE TABLE REALIZAR(
tratamiento char(5) constraint fk_realizar_tratamiento references tratamiento,
empleado char(9) constraint fk_realizar_empservicios references empservicios,
constraint pk_realizar primary key(tratamiento, empleado));

CREATE TABLE CITA(
fecha date,
momento number(1) constraint check_momento check(momento between 1 and 6),
empleado char(9),
cliente char(9) constraint fk_cita_cliente references cliente not null,
tratamiento char(5)  not null,
constraint pk_cita primary key(fecha, momento, empleado),
constraint fk_cita_realizar foreign key (tratamiento, empleado) references realizar);

--Para controlar que el empleado de servicio realice el servicio de la cita se ha dirigido
-- la clave ajena compuesta a la tabla realizar. Siguiendo las reglas de transformación 
-- del EER al MR tendríamos dos claves ajenas empleado y tratamiento hacia sus respectivas tablas.


---- TABLAS YA CREADAS A LAS QUE FALTA RELACIONAR CON LAS NUEVAS

ALTER TABLE CALENDARIO
add emplimpieza char(9) constraint fk_calendario_emplimpieza references emplimpieza;

ALTER TABLE ACTIVIDAD
add empanimacion char(9) constraint fk_actividad_empanimacion references empanimacion;

-------------------------------------------------Ejercicio 1--------------------------------------------------------------------
--
alter table calendreservas add alimentacion char(2)
constraint chAlimentacionCalendreservas check (alimentacion in ('SA', 'AD', 'MP', 'PC'));

insert into categoria(nombre, descripcion, supmin) 
values ('S','SECADOR, MINIBAR, HIDROMASAJE, ADMITE SUPLETORIA',25);
--------------------------------------------------------------------------

update pvptemporada set pSA= 75, pAD= 80, pMP= 95, pPC= 110 where categoria='DT' and temporada='BAJA';
update pvptemporada set pSA= 75, pAD= 85, pMP= 100, pPC= 120 where categoria='DT' and temporada='MEDIA';
update pvptemporada set pSA= 75, pAD= 90, pMP= 105, pPC= 130 where categoria='DT' and temporada='ALTA';

insert into pvptemporada values ('S','BAJA', 100, 105, 125,135);
insert into pvptemporada values ('S','MEDIA', 115, 120, 130, 145);
insert into pvptemporada values ('S','ALTA', 140, 145, 160, 175);
-----------------------------------------------------------------------------------------

insert into EMPLEADO values ('21455588A','Alicia Martínez Escolano','Rueda 25','Alicante','686112233','Administrativo');
insert into EMPLEADO values ('22222222B','Alberto Manresa Ruiz','Molinos 32','Calpe','656543201','Administrativo');
insert into EMPLEADO values ('33333333C','Mario Campos Rojo','Huertas grandes 27','Altea','686768999','Curso de animador social');
insert into EMPLEADO values ('44444444D','Maria López Sánchez','Almirante 27','Alicante','649172324',NULL);
insert into EMPLEADO values ('55555555D','Raul León Escobar','Hacienda 27','Altea','966756543',NULL);
insert into EMPLEADO values ('66666666D','Roberto Escobar García','Hacienda 27','Altea','966756543',NULL);
-----------------------------------------------------------------------------------
insert into EMPLIMPIEZA values('44444444D');
insert into EMPLIMPIEZA values('55555555D');
insert into EMPLIMPIEZA values('66666666D');
insert into EMPANIMACION values('33333333C');
------------------------------------------------------------------------------------
update calendario set emplimpieza='44444444D' where fecha='01/11/2012';
update calendario set emplimpieza='44444444D' where fecha='02/11/2012';
update calendario set emplimpieza='44444444D' where fecha='03/11/2012';
update calendario set emplimpieza='44444444D' where fecha='04/11/2012';
update calendario set emplimpieza='44444444D' where fecha='05/11/2012';
update calendario set emplimpieza='44444444D' where fecha='06/11/2012';
update calendario set emplimpieza='44444444D' where fecha='07/11/2012';
update calendario set emplimpieza='44444444D' where fecha='08/11/2012';
update calendario set emplimpieza='44444444D' where fecha='09/11/2012';
update calendario set emplimpieza='44444444D' where fecha='10/11/2012';
update calendario set emplimpieza='44444444D' where fecha='11/11/2012';
update calendario set emplimpieza='44444444D' where fecha='12/11/2012';
update calendario set emplimpieza='44444444D' where fecha='13/11/2012';
update calendario set emplimpieza='44444444D' where fecha='14/11/2012';
update calendario set emplimpieza='44444444D' where fecha='15/11/2012';
update calendario set emplimpieza='44444444D' where fecha='16/11/2012';
update calendario set emplimpieza='55555555D' where fecha='17/11/2012';
update calendario set emplimpieza='55555555D' where fecha='18/11/2012';
update calendario set emplimpieza='55555555D' where fecha='19/11/2012';
update calendario set emplimpieza='55555555D' where fecha='20/11/2012';
update calendario set emplimpieza='55555555D' where fecha='21/11/2012';
update calendario set emplimpieza='55555555D' where fecha='22/11/2012';
update calendario set emplimpieza='55555555D' where fecha='23/11/2012';
update calendario set emplimpieza='55555555D' where fecha='24/11/2012';
update calendario set emplimpieza='55555555D' where fecha='25/11/2012';
update calendario set emplimpieza='55555555D' where fecha='26/11/2012';
update calendario set emplimpieza='55555555D' where fecha='27/11/2012';



update calendario set emplimpieza='44444444D' where fecha='05/03/2013';
update calendario set emplimpieza='44444444D' where fecha='07/03/2013';
update calendario set emplimpieza='44444444D' where fecha='09/03/2013';
update calendario set emplimpieza='55555555D' where fecha='11/03/2013';
update calendario set emplimpieza='55555555D' where fecha='12/03/2013';


update calendario set emplimpieza='44444444D' where fecha='01/08/2013';
update calendario set emplimpieza='44444444D' where fecha='02/08/2013';
update calendario set emplimpieza='44444444D' where fecha='03/08/2013';
update calendario set emplimpieza='44444444D' where fecha='04/08/2013';
update calendario set emplimpieza='44444444D' where fecha='05/08/2013';
update calendario set emplimpieza='44444444D' where fecha='06/08/2013';
update calendario set emplimpieza='44444444D' where fecha='07/08/2013';
update calendario set emplimpieza='44444444D' where fecha='08/08/2013';
update calendario set emplimpieza='44444444D' where fecha='09/08/2013';
update calendario set emplimpieza='44444444D' where fecha='10/08/2013';
update calendario set emplimpieza='44444444D' where fecha='11/08/2013';
update calendario set emplimpieza='55555555D' where fecha='12/08/2013';
update calendario set emplimpieza='55555555D' where fecha='13/08/2013';
update calendario set emplimpieza='55555555D' where fecha='14/08/2013';
update calendario set emplimpieza='55555555D' where fecha='15/08/2013';
update calendario set emplimpieza='55555555D' where fecha='16/08/2013';
update calendario set emplimpieza='55555555D' where fecha='17/08/2013';
update calendario set emplimpieza='55555555D' where fecha='18/08/2013';
update calendario set emplimpieza='55555555D' where fecha='19/08/2013';
update calendario set emplimpieza='55555555D' where fecha='20/08/2013';
update calendario set emplimpieza='55555555D' where fecha='21/08/2013';
update calendario set emplimpieza='55555555D' where fecha='22/08/2013';
update calendario set emplimpieza='55555555D' where fecha='23/08/2013';
update calendario set emplimpieza='55555555D' where fecha='24/08/2013';
update calendario set emplimpieza='66666666D' where fecha='25/08/2013';
update calendario set emplimpieza='66666666D' where fecha='26/08/2013';
update calendario set emplimpieza='66666666D' where fecha='27/08/2013';
update calendario set emplimpieza='66666666D' where fecha='28/08/2013';
update calendario set emplimpieza='66666666D' where fecha='29/08/2013';
update calendario set emplimpieza='66666666D' where fecha='30/08/2013';
update calendario set emplimpieza='66666666D' where fecha='31/08/2013';


-------------------------------------------------------
insert into SERVICIO values ('AG01','Agua mineral sin gas', 1.5);
insert into SERVICIO values ('AG02','Agua mineral con gas', 1.5);
insert into SERVICIO values ('RE01','Coca-cola', 2.5);
insert into SERVICIO values ('RE02','Fanta naranja', 2.5);
insert into SERVICIO values ('RE03','Fanta limón', 2.5);
insert into SERVICIO values ('CE01','Cerveza Mahou 0.0', 2.5);
insert into SERVICIO values ('CE02','Cerveza Heineken', 2.5);
insert into SERVICIO values ('SN01','Almendras', 2.5);
insert into SERVICIO values ('SN02','Chips', 1.5);
insert into SERVICIO values ('SN03','Mars', 1.5);
-------------------------------------------------------------------

insert into CLIENTE values ('21446688A','Almudena Urquijo Martínez','686756743','San Martín de Valdeiglesias', 'Madrid', 'España');
insert into CLIENTE values ('45113377M','Javier Robledo Cañizares','656769903','Denia', 'Alicante', 'España');
insert into CLIENTE values ('21123456Z','Sara Pérez Caballero','656769903','Vinaroz', 'Castellón', 'España');
insert into CLIENTE values ('21778899P','Pablo Álvarez Redondo','646577816','San Juan', 'Alicante', 'España');
insert into CLIENTE values ('45987688P','Pedro Bernabeu Ramos','577151586','Alicante', 'Alicante', 'España');
insert into CLIENTE values ('21668899P','Nicolás Álvarez Redondo','646577816','Elche', 'Alicante', 'España');
insert into CLIENTE values ('X21778800','Natalia Ramos Rico','656487502','Roma', 'Roma', 'Italia');
-----------------------------------------------------------------------------
insert into RESERVA values (1, '21446688A');
insert into RESERVA values (2, '45113377M');
insert into RESERVA values (3, '21123456Z');
insert into RESERVA values (4, '21446688A');
insert into RESERVA values (5, '21446688A');
insert into RESERVA values (6, '45113377M');
insert into RESERVA values (7, '45987688P');
---------------------------------------------------------------------------------
insert into CALENDRESERVAS values(1,'10/11/2012','NO',1,'MP');
insert into CALENDRESERVAS values(1,'12/11/2012','NO',2,'MP');
insert into CALENDRESERVAS values(2,'12/11/2012','NO',2,'MP');
insert into CALENDRESERVAS values(1,'13/11/2012','NO',2,'MP');
insert into CALENDRESERVAS values(2,'13/11/2012','NO',2,'MP');
insert into CALENDRESERVAS values(1,'14/11/2012','NO',3,'MP');
insert into CALENDRESERVAS values(2,'14/11/2012','NO',3,'MP');
insert into CALENDRESERVAS values(3,'14/11/2012','NO',3,'MP');
insert into CALENDRESERVAS values(1,'15/11/2012','NO',3,'AD');
insert into CALENDRESERVAS values(2,'15/11/2012','NO',3,'AD');
insert into CALENDRESERVAS values(3,'15/11/2012','NO',3,'AD');
insert into CALENDRESERVAS values(7,'15/11/2012','NO',4,'SA');
insert into CALENDRESERVAS values(4,'15/11/2012','NO',5,'PC');
insert into CALENDRESERVAS values(4,'16/11/2012','NO',6,'AD');
insert into CALENDRESERVAS values(3,'16/11/2012','SI',7,'PC');

----------------------------------------------------------------------
insert into CONSUMIR values(1,'10/11/2012','AG01',2);
insert into CONSUMIR values(1,'10/11/2012','SN01',1);
insert into CONSUMIR values(1,'10/11/2012','SN02',1);
insert into CONSUMIR values(1,'12/11/2012','AG02',1);
insert into CONSUMIR values(2,'12/11/2012','AG02',2);
-------------------------
update ACTIVIDAD set empanimacion='33333333C' where codigo='PET';
update ACTIVIDAD set empanimacion='33333333C' where codigo='PAR';

---------------------------------------------------------
update habitacion set superficie=18,piso=1 where numero=5;
update habitacion set superficie=18,piso=1 where numero=6;
insert into habitacion values(8,'S',26,7);
insert into habitacion values(9,'S',32,7);
----------------------------------------------------
insert into EMPLEADO values ('77777777S','Marta Sánchez Alberola','Bazán 2','Elche','649155324',NULL);
insert into EMPLEADO values ('88888888S','Roberto Miralles Ros','Castaños 7','Alcoy','677753543','Fisioterapia');
insert into EMPLEADO values ('99999999S','Roberto Escobar García','Hacienda 27','Altea','676889054',NULL);
insert into EMPSERVICIOS values('77777777S');
insert into EMPSERVICIOS values('88888888S');
insert into EMPSERVICIOS values('99999999S');
------------------------------------------------
insert into TRATAMIENTO values('MAS01','Masaje de espalda', 25);
insert into TRATAMIENTO values('MAS02','Masaje de piernas', 20);
insert into TRATAMIENTO values('PEL01','Corte de pelo corto', 20);
insert into TRATAMIENTO values('PEL02','Corte de pelo largo', 25);
insert into TRATAMIENTO values('PED01','Pedicura', 30);
insert into TRATAMIENTO values('FAC01', 'Limpieza de cutis',25);
insert into TRATAMIENTO values('DEP01','Depilación de cejas', 10);
------------------------------------------------
insert into REALIZAR values('MAS01','77777777S');
insert into REALIZAR values('MAS02','77777777S');
insert into REALIZAR values('DEP01','77777777S');
insert into REALIZAR values('FAC01','77777777S');
insert into REALIZAR values('MAS01','88888888S');
insert into REALIZAR values('PED01','88888888S');
insert into REALIZAR values('DEP01','88888888S');
insert into REALIZAR values('MAS01','99999999S');
insert into REALIZAR values('PEL01','99999999S');
insert into REALIZAR values('PEL02','99999999S');
insert into REALIZAR values('MAS02','99999999S');
------------------------------------------------
insert into CITA values('15/11/2012',1,'77777777S','21446688A','MAS01');
insert into CITA values('15/11/2012',2,'77777777S','21446688A','DEP01');
insert into CITA values('15/11/2012',2,'88888888S','45113377M','DEP01');
insert into CITA values('15/11/2012',4,'77777777S','45113377M','MAS01');
insert into CITA values('18/11/2012',1,'77777777S','45113377M','MAS01');
insert into CITA values('18/11/2012',3,'77777777S','21668899P','FAC01');
insert into CITA values('18/11/2012',2,'99999999S','21668899P','MAS02');


-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
delete malcategoria;
select * from malcategoria;

create or replace procedure verminsuperficie is
  cursor c1 is select numero, superficie, supMin 
  from habitacion join categoria on categoria=nombre;
begin
  for regc1 in c1 loop
    if(regc1.superficie is null or regc1.supMin is null) then
      if regc1.superficie is null then
        escribir('Habitacion ' || regc1.numero || ' superficie sin valor');
      end if;
      if regc1.supMin is null then
        escribir('Habitación ' || regc1.numero || ' superficie sin valor');
      end if;
    else
      if(regc1.superficie < regc1.supMin) then
        escribir('Habitación ' || regc1.numero || ' dimension incorrecta');
        insert into malcategoria values(regc1.numero, regc1.supMin - regc1.superficie);
      else
        escribir('Habitacion ' || regc1.numero || ' dimension correcta');
      end if;
    end if;
  end loop;
end;
      
-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
create or replace procedure verActividad (p_fecha in date) is
  declare
    cursor c1 is select hora, codigo, actividad 
    from horario join actividad on actividad=codigo 
    where fecha=p_fecha 
    order by hora;
  begin
    for regc1 in c1 loop
      escribir(regc1.hora || ' horas ' || regc1.codigo || ' ' || regc1.descripcion);
    end loop;
  end;  
  
-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
create or replace procedure mostrarEquivalentes (p_actAdulto in sustadultos.activ1%type) is
    v_nomActividad actividad.descripcion%type;
    cursor cAdultos is select activ2, descripcion
    from sustadultos join actividad on activ2=codigo
    where p_actAdulto=activ1
    order by descripcion;
  begin
    select descripcion into v_nomActividad 
    from actividad
    where p_actAdulto=codigo;
    escribir('Las actividades sustitutas de la actividad ' || v_nomActividad || ' son: ');
    for regAdultos in cAdultos loop
      escribir(regAdultos.activ2 || ' ' || regAdultos.descripcion);
    end loop;
  end;
--Prueba
select * from actadultos;
exec mostrarEquivalentes('PET');

-------------------------------------------------Ejercicio 5--------------------------------------------------------------------
create table adaptadas(habitacion number(3) 
constraint pkAdaptadas primary key
constraint fkAdaptadas_Habitacion references habitacion);

-------------------------------------------------Ejercicio 6--------------------------------------------------------------------
create or replace procedure CompletaAdaptadas is
  contador number(3):=0;
  cursor cAdaptadas is select numero from habitacion where piso=0 and superficie>25;
  begin
    for regcAdaptadas in cAdaptadas loop
      insert into adaptadas values(regcAdaptadas.numero);
      contador := contador + 1;
    end loop;
    escribir('Se han dado de alta ' || contador || ' habitaciones adaptadas');
  end;  
  exec CompletaAdaptadas;

-------------------------------------------------Ejercicio 7--------------------------------------------------------------------
create or replace procedure revisaPreciosTemporada (p_temporada in temporada.nombre%type) is
  begin
    update pvptemporada set pad=psa*1.1, pmp=psa*1.2, ppc=psa*1.3
    where temporada=p_temporada and psa is not null;
  end;  
  
-------------------------------------------------Ejercicio 8--------------------------------------------------------------------
create or replace procedure listaActividades is
 cursor cActs is
 select codigo, descripcion
 from actividad
 where codigo not in (
 select activ1 from sustninos union
 select activ1 from sustadultos union
 select activ1 from susttodos);
 begin
  for regAct in cAtcs loop
    escribir('Actividad sin sustituta ' || regAct.codigo || ' ' || regAct.descripcion);
  end loop;
  end;
      
      
      
      
      
      
      
      