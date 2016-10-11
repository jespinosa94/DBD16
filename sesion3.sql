
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

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
















