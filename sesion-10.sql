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
create or replace function ej1(p_cod servicio.codigo%type) return number is
  precioServicio number(5,2):=NULL;
begin
  select precio into precioServicio
  from servicio
  where p_cod=codigo;
  
  escribir('El precio del servicio ' || p_cod || ' es: ' || precioServicio);
  return(precioServicio);

exception
  when no_data_found then
    escribir('No se encuentra el servicio con código ' || p_cod);
    return null;
end;
  
exec ej1('olaa'); --Excepción
exec ej1('CE02');

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
--Falta controlar que se meta mal la categoria, no salta error por el avg()
create or replace function Pr10ej2(p_cat categoria.nombre%type, p_regimen calendreservas.alimentacion%type) return number is
precioMedio number(5, 2):=0;
total number(1);
no_existe_categoria exception;
begin
  select count(*) into total from pvptemporada where upper(p_cat) = categoria;
  
  if total=0 then raise no_existe_categoria;
  end if;
  
  if upper(p_regimen)='SA' then
    select avg(psa) into precioMedio
    from pvptemporada
    where categoria=p_cat;
  else if upper(p_regimen)='AD' then
    select avg(pad) into precioMedio
    from pvptemporada where categoria=p_cat;
  else if upper(p_regimen)='MP' then
    select avg(pmp) into precioMedio
    from pvptemporada
    where categoria=p_cat;
  else if upper(p_regimen)='PC' then
    select avg(ppc) into precioMedio
    from pvptemporada
    where categoria=p_cat;
  else
    escribir('El tipo de la categoria es incorrecto');
  end if;
  end if;
  end if;
  end if;
  
  if precioMedio is null then
    escribir('Los valores de precio no están rellenados');
  end if;  
  --escribir('La media del precio de la categoria ' || p_cat || ' es: ' || precioMedio);
  return precioMedio;
exception
  when value_error then
    escribir('Los valores especificados no son correctos');
    return null;
  when no_data_found then
    escribir('El valor especificado es incorrecto');
    return null;
  when no_existe_categoria then 
    escribir('El valor de la categoría no es correcto');
    return null;
end;

exec ej2('S', 'SA');
exec ej2('I', 'sa');
exec ej2('I', 'fedsgt34');
exec ej2('H', 'sa');  --Error porque la categoría H no existe, pero al hacer avg() si que entra en la select (No se como filtrar que al no devolver resultados salte una excepción)

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
/*Obtener un listado en el que figure cada categoría junto con el precio medio (entre
todas las temporadas) para SA, para AD, para MP y para PC. Debes apoyarte en la
función anterior para realizar este ejercicio.*/

create or replace procedure Pr10ej3 is
cursor categ is select nombre from categoria;
begin
  for cat in categ loop
    escribir(cat.nombre || ' SA: ' || Pr10ej2(cat.nombre, 'SA') || ' AD: ' || pr10ej2(cat.nombre, 'AD') 
    || ' MP: ' || pr10ej2(cat.nombre, 'MP') || ' PC: ' || pr10ej2(car.nombre, 'PC');
  end loop;
end;  

-------------------------------------------------Ejercicio 4--------------------------------------------------------------------
create or replace function pr10ej4(p_fecha date, p_categoria categoria.nombre%type) return number is
total number(2):=0;
auxcategoria categoria.nombre%type;
begin
  select nombre into auxcategoria from categoria where nombre = p_categoria;
  select count(*) into total from calendreservas 
  where fecha=p_fecha and habitacion in
  (select numero from habitacion where categoria=p_categoria);
  return (total);
  
exception
when no_data_found_exception then
  escribir('No existe esa categoría de habitación en el hotel');
  return null;
end;

-------------------------------------------------Ejercicio 5--------------------------------------------------------------------
create or replace function pr10ej5(p_codReserva reserva.codigo%type, p_habitacion habitacion.numero%type) return number is
gasto number (7,2):=null;

begin
  select sum(precio*co.cantidad) into gasto from
  calendreservas ca join consumir co on ca.habitacion=co.habitación
  join servicio on co.servicio=codigo
  where ca.fecha=co.fecha and ca.habitacion=p_habitacion and ca.reserva=p_codReserva;
  
  if gasto is null then 
    escribir('El numero de reserva es incorrecto');
  end if;
  return (gasto);
end;

----con cursor
create or replace function pr10ej5.2(p_codReserva reserva.cod%type, p_hab habitacion.numero%type) return number is
auxreserva reserva.codigo%type;
auxhabitacion habitacion.numero%type;
auxgasto number(7,2):=0;
gasto number(7,2):=0;
cursor dias_reserva is select fecha from calendreservas 
where reserva=p_codReserva and habitacion=p_habitacion;

begin
  select numero into auxhabitacion from habitacion where numero=p_habitacion;
  select codigo into auxreserva from reserva where codigo=p_codReserva;
  
  for diaReserva in dias_reserva loop
    select sum(precio*cantidad)into auxgasto from servicio join consumir on codigo=servicio
    where habitacion=p_habitacion and fecha=diaReserva.fecha;
    gasto:=gasto+auxgasto;
  end loop;
  return (gasto);
  
  exception
  when no_data_found then
  escribir('Verificar el numero de reserva o de habitacion');
  return null;
end;

-------------------------------------------------Ejercicio 6--------------------------------------------------------------------
create or replace function pr10ej6(p_cod reserva.codigo%type) return number is
auxreserva reserva.codigo%type;
gasto number(7,2):=0;
cursor hab_reserva is select distinct habitacion from calendreservas
where reserva=p_cod;

begin
select codigo into auxreserva from reserva where codigo=p_cod;

for hr in hab_reserva loop
  gasto:= gasto + pr10ej5(auxreserva, hr.habitacion);
end loop;
return (gasto);

exception
when no_data_found then
escribir('El numero de la reserva es incorrecto');
return null;
end;

select pr10ej6(3) from dual;

-------------------------------------------------Ejercicio 7--------------------------------------------------------------------
create table clientevip(nif char(9) 
constraint fk_clientevip_cliente references cliente
constraint pk_clientevip primary key);

-------------------------------------------------Ejercicio 8--------------------------------------------------------------------
create or replace function pr10ej8(p_nif cliente.nif%type, p_anyo char) return number is
gasto number(10,2):=0;
auxnif cliente.nif%type;
cursor reservas is select distinct reserva from calendreservas 
where to_char(fecha,'yyyy') = p_anyo and reserva=codigo and cliente=p_nif);

begin
  select nif into auxnif from cliente where nif=p_nif;
  
  for reserva in reservas loop
    gasto:=gasto + pr10ej6(reserva.reserva);
  end loop;
  return (gasto);
  
  exception
  when no_data_found then
  escribir('El nif introducido es incorrecto');
  return null;
end;

create or replace procedure pr10ej9(cantidadVIP number) is
total number(7,2):=0;
cursor clientes is select nif from cliente;
begin
  for cliente in clientes loop
    total = pr10ej8('2016');
    if total>cantidadVIP then
      insert into clientevip values(cliente);
    end if;
  end loop;
  
  exception
  when data_not_found then
    escribir('Eres demasiado rico y para ti el dinero no es importante');
end;  