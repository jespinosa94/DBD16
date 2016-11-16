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
create or replace procedure ej2(p_cat categoria.nombre%type, p_regimen calendreservas.alimentacion%type) is
precioMedio number(5, 2);
begin
  if upper(p_regimen)='SA' and select * from pvptemporada where p_cat=categoria then
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
  escribir('La media del precio de la categoria ' || p_cat || ' es: ' || precioMedio);
exception
  when value_error then
    escribir('Los valores especificados no son correctos');
  when no_data_found then
    escribir('El valor especificado es incorrecto');
end;

exec ej2('S', 'SA');
exec ej2('I', 'sa');
exec ej2('I', 'fedsgt34');
exec ej2('H', 'sa');











