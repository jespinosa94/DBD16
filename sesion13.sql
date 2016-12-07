-----------------------------Ejercicio 1 COMMIT, SAVEPOINT, ROLLBACK-------------------------
create table prueba1(a number (2) constraint pkprueba1 primary key, b number(5));
create table prueba2(a char(1) constraint pkprueba2 primary key, b number(4));
--
insert into prueba1 values(1, 3400);
insert into prueba1 values(4, 4100);
insert into prueba1 values(8, 3700);
select * from prueba1; --Muestra los valores introducidos en la tabla
--
commit;
select * from prueba1; --Muestra los valores introducidos en la tabla
--
insert into prueba2
values('A',1);
insert into prueba2
values('B',1);
insert into prueba2
values('C',1);
savepoint punto1;
insert into prueba2
values('D',4);
insert into prueba2
values('E',4);
insert into prueba2
values('F',4);
insert into prueba2
values('G',4);
insert into prueba2
values('H',8);
select * from prueba2; --Muestra todos los valores hasta H,8
--
rollback to savepoint punto1;
select * from prueba2; --Muestra los valores hasta C
--
commit;
select * from prueba2; --Muestra los valores hasta C


        ----------[SESION DEL OTRO USUARIO]
                    select * from prueba1; --No muestra resultados
                    --
                    select * from prueba1; --Muestra los resultados ejecutados en la otra sesión
                    --
                    select * from prueba2; -- No muestra resultados
                    --
                    select * from prueba2; -- No muestra resultados
                    --
                    select * from prueba2; --Muestra los valores hasta C,1

-----------------------------Ejercicio 2 GRANT Y REVOKE-------------------------
--Usuario: dbd_mi11pc18
--Pass: dbd
grant select on empleado to dbd_mi11pc18;
--8--
grant insert on empleado to dbd_mi11pc18;
--10--
revoke insert on empleado from dbd_mi11pc18;

            -------[SESION DEL OTRO USUARIO]
                    select * from empleado;
                    select * from dbd_jec21.empleado;
                    --6--
                    select * from empleado;
                    select * from dbd_jec21.empleado; -- Muestra los resultados de la tabla del otro usuario
                    --7--
                    INSERT INTO DBD_JEC21.EMPLEADO
                    (nif, nombre, DIRECCIÓN, POBLACIÓN) 
                    values('00000007A', 'CARLOS RUIZ', 'Estrella 35', 'POLOP'); --No permite insertar
                    --9--
                    INSERT INTO DBD_JEC21.EMPLEADO
                    (nif, nombre, DIRECCIÓN, POBLACIÓN) 
                    values('00000007A', 'CARLOS RUIZ', 'Estrella 35', 'POLOP'); --Los datos se insertan correctamente
                    --11--
                    INSERT INTO DBD_JEC21.EMPLEADO
                    (nif, nombre, DIRECCIÓN, POBLACIÓN) 
                    values('00000008B', 'Rosa Guardiola', 'Lucero 47', 'San Juan'); --No permite insertar

--12--
create table tratamiento_caro(codigo char(5) constraint pktratamientoCaro primary key,
precio number (3));
--13--
insert into tratamiento_caro(codigo, precio) 
select codigo, precio from tratamiento 
where precio > 20;
--14--
explain plan 
set statement_id='tratamiento1'
for insert into tratamiento_caro(codigo, precio) 
select codigo, precio from tratamiento 
where precio > 20;

select operation, options, object_name, position 
from plan_table
where statement_id='tratamiento1';
--Resultado sin indice: (3,1,1)
--Resultado con indice: (3,1,1,2,1,1,1)
--15--
create index indexPrecio on tratamiento(precio);
--El resultado no es el mismo, ahora se contemplan más operaciones sobre las
--tablas tratamiento y tratamiento_caro


















