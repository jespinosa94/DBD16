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
create or replace procedure ej1(p_cod servicio.codigo%type)  is
  precioServicio number(5,2);
begin
  select precio into precioServicio
  from servicio
  where p_cod=codigo;
  
  escribir('El precio del servicio ' || p_cod || ' es: ' || precioServicio);

exception
  when no_data_found then
    escribir('No se encuentra el servicio con código ' || p_cod);
end;
  
exec ej1('olaa'); --Excepción
exec ej1('CE02');

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
--Falta controlar que se meta mal la categoria, no salta error por el avg()
create or replace function ej2(p_cat categoria.nombre%type, p_regimen calendreservas.alimentacion%type) return number is
precioMedio number(5, 2);
begin
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
    raise no_data_found;
  end if;
  end if;
  end if;
  end if;
  --escribir('La media del precio de la categoria ' || p_cat || ' es: ' || precioMedio);
  return precioMedio;
exception
  when value_error then
    escribir('Los valores especificados no son correctos');
  when no_data_found then
    escribir('El valor especificado es incorrecto');
end;

exec ej2('S', 'SA');
exec ej2('I', 'sa');
exec ej2('I', 'fedsgt34');
exec ej2('H', 'sa');  --Error porque la categoría H no existe, pero al hacer avg() si que entra en la select (No se como filtrar que al no devolver resultados salte una excepción)

-------------------------------------------------Ejercicio 3--------------------------------------------------------------------
/*Obtener un listado en el que figure cada categoría junto con el precio medio (entre
todas las temporadas) para SA, para AD, para MP y para PC. Debes apoyarte en la
función anterior para realizar este ejercicio.*/










