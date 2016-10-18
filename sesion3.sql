-------------------------------------------------Ejercicio 1--------------------------------------------------------------------
--
create table TEMPORADA(nombre varchar(5), constraint pktemporada primary key(nombre));
--
create table CATEGORIA(nombre varchar(2), descripcion varchar(80), supMin number(4,2), supMax number(4,2), 
constraint pkcategoria primary key(nombre), constraint chcatnombre check(nombre in ('D', 'DT', 'I', 'S')));
--
create table PVPTEMPORADA(categoria varchar(2), temporada varchar(5), pSA number(3), pAD number(3), pMP number(3), pPC number(3), 
constraint pkpvptemp primary key(categoria, temporada), 
constraint fkpvptempcat foreign key (categoria) references CATEGORIA,
constraint fkpvptemptemp foreign key (temporada) references TEMPORADA);
--
create table HABITACION(numero number(3), categoria varchar(2) not null,
constraint pkHab primary key (numero),
constraint fkHab foreign key (categoria) references CATEGORIA);

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
--
alter table CATEGORIA modify (descripcion not null);
--
alter table TEMPORADA add constraint chTEMPNOMBRE check(nombre in ('BAJA', 'MEDIA', 'ALTA'));
--
alter table HABITACION modify categoria default 'D';
--
alter table PVPTEMPORADA modify pSA default 60;

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
create table T1(a number(2), b number(2), c number(2), d number(2),
constraint pkT1 primary key(a, b));
--
create table T2(a number(2), b number(2) not null, c number(2), d number(2),
constraint pkT2 primary key (a),
constraint ukT2 unique (b));
--
create table T3(a number(2), b number(2) not null, c number(2) not null, d number(2),
constraint pkT3 primary key (a),
constraint ukT3 unique (b, c));
--
create table T4(a number(2), b number(2) not null, c number(2) not null, d number(2),
constraint pkT4 primary key(a),
constraint uk1T4 unique (b),
constraint uk2T4 unique (c));
--
/*Cada una de las tablas tiene unas restricciones concretas que tienen funciones distintas
en un sistema de información*/

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
insert into CATEGORIA (nombre, descripcion, supMin) 
values ('D', 'SECADOR, MINIBAR, AMPLIA, DOS CAMAS, ADMITE SUPLETORIA', 15);
--
insert into categoria (nombre, descripcion, supmin)
values('DT', 'SECADOR, MINIBAR, AMPLIA, DOS CAMAS, ADMITE SUPLETORIA, TERRAZA AL PARQUE', 15);
--
insert into categoria (nombre, descripcion, supmax)
values('I', 'UNA CAMA, SECADOR', 12);
--
insert into temporada values('BAJA');
insert into temporada values('MEDIA');
insert into temporada values('ALTA');
--
insert into temporada values('DISTINTA'); --ERROR, solo se pueden introducir los datos anteriores--
--
insert into habitacion values(1, 'D');
insert into habitacion values(2, 'D');
insert into habitacion values(3, 'D');
-
insert into habitacion values(3, 'I'); --ERROR, la habitacion 3 ya existe--
insert into habitacion values(4, 'I');
insert into habitacion values(5, 'E');--ERROR. una habitación no puede ser E--
insert into habitacion values(5, 'DT');
insert into habitacion values(6, 'DT');

-------------------------------------------------Ejercicio 5--------------------------------------------------------------------
insert into pvptemporada (categoria, temporada) values('I', 'BAJA');
insert into pvptemporada (categoria, temporada) values('I', 'MEDIA');
insert into pvptemporada (categoria, temporada) values('I', 'ALTA');
insert into pvptemporada (categoria, temporada, psa) values('D', 'BAJA', 65);
insert into pvptemporada (categoria, temporada, psa) values('D', 'MEDIA', 65);
insert into pvptemporada (categoria, temporada, psa) values('D', 'ALTA', 65);
insert into pvptemporada (categoria, temporada) values('DT', 'BAJA');
insert into pvptemporada (categoria, temporada) values('DT', 'MEDIA');
insert into pvptemporada (categoria, temporada) values('DT', 'ALTA');
--Las de abajo no funcionan, la categoria S no existe--
insert into pvptemporada (categoria, temporada) values('S', 'BAJA');
insert into pvptemporada (categoria, temporada) values('S', 'MEDIA');
insert into pvptemporada (categoria, temporada) values('S', 'ALTA');

-------------------------------------------------Ejercicio 6--------------------------------------------------------------------
delete from categoria where nombre = 'S'; --Funciona pero no borra nada porque no hay filas--

-------------------------------------------------Ejercicio 7--------------------------------------------------------------------
delete from categoria where nombre = 'D'; --viola la integridad referencial categoria -> pvptemporada--

-------------------------------------------------Ejercicio 8--------------------------------------------------------------------
update pvptemporada set psa = 100
where categoria = 'D' and temporada = 'BAJA';
--
update pvptemporada set psa = 115
where categoria = 'D' and temporada = 'media';
--
update pvptemporada set psa = 140
where categoria = 'D' and temporada = 'alta';

-------------------------------------------------Ejercicio 9--------------------------------------------------------------------
insert into habitacion (numero) values (7);

-------------------------------------------------Ejercicio 10--------------------------------------------------------------------
create table n_df (nombre varchar(5) primary key, descripcion varchar(5) default 'olis');
--
create table n (nombre varchar(5) primary key, descripcion varchar(5));
--
create table nn_df (nombre varchar(5), descripcion varchar(5) default 'oliki' not null);
--
create table nn (nombre varchar(5), descripcion varchar(5) not null);
--
select * from n_df;
insert into n_df (nombre, descripcion) values ('uno', null); --Pone NULL
insert into n_df values('dos', default); --Asigna el valor por defecto
insert into n_df (nombre) values('tres'); --Asigna el valor por defecto
--
select * from n;
insert into n values('uno', null); --pone null
insert into n values('dos', default); --pone null
insert into n (nombre) values('tres'); --pone null
--
select * from nn_df;
insert into nn_df values('uno', null); --falla porque necesita un valor
insert into nn_df values('dos', default); --asigna el valor por defecto 'oliki'
insert into nn_df (nombre) values ('dos'); --asigna el valor por defecto 'oliki'
--
select * from nn;
insert into nn values('uno', null); --Error: no admite null
insert into nn values('dos', default); --Error: default es null y no lo admite
insert into nn (nombre) values('tres'); --Error: pone el valor por defecto null y no lo admite