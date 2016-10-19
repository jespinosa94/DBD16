/*c1 select a.nombre nomcliente, count(*) total;
 *hay que renombrar los atributos con a. o funciones 
 *para que no de error al compilar el cursor
**/

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

DECLARE
  cursor c1 is select superficie from habitacion;
BEGIN
  for regc1 in c1 loop
  Dbms_output.put_line(regc1.cod);
  end loop;
END;












