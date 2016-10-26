/*c1 select a.nombre nomcliente, count(*) total;
 *hay que renombrar los atributos con a. o funciones 
 *para que no de error al compilar el cursor
**/


--Ejecutar entes de iniciar el script
set serveroutput on;

-------------------------------------------------Ejercicio 1--------------------------------------------------------------------

create table calendario(fecha date, temporada varchar(5), 
constraint pkcalendario primary key(fecha));
--
create table hora(hora number(2), constraint pkhora primary key(hora));
--
create table actividad(codigo char(4), descripcion varchar(100) not null,
constraint pkactividad primary key(codigo));
--
create table horario(fecha date, hora number(2), actividad char(4) not null,
constraint pkhorario primary key(fecha, hora), 
constraint ukhorario unique(fecha, actividad),
constraint fkhorario_calendario foreign key(fecha) references calendario,
constraint fkhorario_hora foreign key(hora) references hora,
constraint fkhorario_actividad foreign key(actividad) references actividad);
--
create table actniños(actividad char(4) constraint pkactniños primary key,
constraint fkactniños foreign key(actividad) references actividad);
--
create table actadultos(actividad char(4) constraint pkactadultos primary key,
constraint fkactadultos foreign key(actividad) references actividad);
--
create table actTodos(actividad char(4) constraint pkactTodos primary key,
constraint fkactTodos foreign key(actividad) references actividad);
--
create table sustNiños(activ1 char(4), activ2 char(4),
constraint pksustNiños primary key(activ1, activ2),
constraint fk1sustNiños_actniños foreign key(activ1) references actniños,
constraint fk2sustNiños_actniños foreign key(activ2) references actniños);
--
create table sustAdultos(activ1 char(4), activ2 char(4),
constraint pksustAdultos primary key(activ1, activ2),
constraint fk1sustAdultos_actAdultos foreign key(activ1) references actadultos,
constraint fk2sustAdultos_actAdultos foreign key(activ2) references actadultos);
--
create table sustTodos(activ1 char(4), activ2 char(4),
constraint pksustTodos primary key(activ1, activ2),
constraint fk1sustTodos_actTodos foreign key(activ1) references acttodos,
constraint fk2sustTodos_actTodos foreign key(activ2) references acttodos);

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
alter table habitacion add(superficie number(4,2), piso number(2));

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
select * from habitacion;

update habitacion set superficie = 17 where numero=1;
--
update habitacion set superficie = 14 where numero=2;
--
update habitacion set superficie = 18 where numero=3;

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------

create table malcategoria(num number(3) primary key, dif number(4,2));

select * from categoria, habitacion;

DECLARE
  cursor c1 is select numero, superficie, supMin 
  from habitacion h join categoria c on h.categoria = c.nombre;
BEGIN
  for regc1 in c1 loop
  if 
    regc1.superficie < regc1.supMin then
    Dbms_output.put_line(' Habitación' || regc1.numero || 'dimensión incorrecta');
    insert into malcategoria values (regc1.numero, regc1.supMin - regc1.superficie);
  else
    Dbms_output.put_line('Habitación' || regc1.numero || 'OK');
  end if;
  end loop;
END;

-------------------------------------------------Ejercicio 5a--------------------------------------------------------------------
--
insert into ACTIVIDAD (codigo, descripcion) values ('FUT', 'Campeonato de Futbol');
insert into ACTIVIDAD (codigo, descripcion) values ('AJE', 'Torneo de Ajedrez');
insert into ACTIVIDAD (codigo, descripcion) values ('PET', 'Torneo de Petanca');
insert into ACTIVIDAD (codigo, descripcion) values ('BAI', 'Baile de Salon');
insert into ACTIVIDAD (codigo, descripcion) values ('PAR', 'Torneo de Parchis');
insert into ACTIVIDAD (codigo, descripcion) values ('SEND', 'Senderismo');
insert into ACTIVIDAD (codigo, descripcion) values ('GOLF', 'Iniciacion al Golf');
insert into ACTIVIDAD (codigo, descripcion) values ('PING', 'Campeonato de Ping Pong');

insert into ACTADULTOS values ('AJE');
insert into ACTADULTOS values ('PET');
insert into ACTADULTOS values ('BAI');
insert into ACTADULTOS values ('PAR');
insert into ACTADULTOS values ('SEND');
insert into ACTADULTOS values ('GOLF');
insert into ACTADULTOS values ('FUT');

insert into SUSTADULTOS values ('AJE', 'PAR');
insert into SUSTADULTOS values ('PET', 'PAR');
insert into SUSTADULTOS values ('BAI', 'PAR');
insert into SUSTADULTOS values ('SEND', 'GOLF');
insert into SUSTADULTOS values ('SEND', 'BAI');
insert into SUSTADULTOS values ('FUT', 'BAI');
insert into SUSTADULTOS values ('GOLF', 'BAI');


insert into HORA values (10);
insert into HORA values (12);
insert into HORA values (18);
insert into HORA values (20);
insert into HORA values (22);




insert into calendario (fecha, temporada) values('01/11/2012', 'BAJA');
insert into calendario (fecha, temporada) values('02/11/2012', 'BAJA');

-------------------------------------------------Ejercicio 5b--------------------------------------------------------------------
--
declare
  cursor c1 is select codigo, activ2, descripcion, count(activ1) numsust, fecha
  from actividad, sustadultos, horario
  where codigo=activ2 and activ1=actividad
  group by codigo, activ2, descripcion, fecha
  having count(*) > 3;
begin
  for regc1 in c1 loop
    Dbms_output.put_line(regc1.activ2 || ', ' || regc1.descripcion || ' conflicto ' ||
    regc1.numsust || ' sustituciones en la fecha ' || regc1.fecha);
  end loop;
end;
  






