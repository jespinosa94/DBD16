-------------------------------------------------Procedimiento ESCRIBIR--------------------------------------------------------------------
--
create or replace procedure escribir(auxcad in varchar) is
begin
dbms_output.enable;
dbms_output.put_line(auxcad);
end;

set serveroutput on format;

-------------------------------------------------Ejercicio 1--------------------------------------------------------------------
create or replace function preciohabitacion (p_numhab habitacion.numero%type, p_fechareserva calendario.fecha%type) return pvptemporada.psa%type is
  v_precio pvptemporada.psa%type;
  begin
    select psa into v_precio 
    from habitacion h, pvptemporada p, calendario c
    where h.numero=p_numhab 
    and c.fecha=p_fechareserva
    and h.categoria=p.categoria 
    and p.temporada=c.temporada;
    return(v_precio);
  end;
  
  select preciohabitacion(1, '16/08/2013') from dual;

-------------------------------------------------Ejercicio 2--------------------------------------------------------------------
create or replace function precioRegimen (p_categoria pvptemporada.categoria%type, p_fechareserva date, p_regimen varchar) return number is
v_psa pvptemporada.psa%type;
v_pad pvptemporada.pad%type;
v_pmp pvptemporada.pmp%type;
v_ppc pvptemporada.ppc%type;
  begin
    select psa, pad, pmp, ppc into v_psa, v_pad, v_pmp, v_ppc
    from pvptemporada p, calendario c
    where p_fechareserva=fecha and p_categoria=p.categoria and c.temporada=p.temporada;
    if p_regimen = 'PSA' then return(v_psa);
      else if p_regimen = 'PAD' then return(v_pad);
        else if p_regimen = 'PMP' then return(v_pmp);
          else if p_regimen = 'PPC' then return(v_ppc);
          end if;
        end if;
      end if;
    end if;
  end;
 -------------------------------------------------Ejercicio 3--------------------------------------------------------------------
 create or replace function cuentaCitas (p_nif in char, p_fecha cita.fecha%type) return number is
  v_citas number(3);
  begin
    select count(*) into v_citas
    from cita join empservicios on empleado=nif
    where p_nif=nif and p_fecha=fecha;
    return(v_citas);
  end;

 -------------------------------------------------Ejercicio 4--------------------------------------------------------------------
 select * from cita;
create or replace function libre(p_empleado empleado.ni%type, p_fecha date, p_momento cita.momento%type) return varchar is
  v_citas number(1);
  v_libre char(2);
  begin
    select count(*) into v_citas
    from cita
    where p_empleado=empleado and p_fecha=fecha and p_momento=momento;
    if v_citas = 0 then v_libre:='SI';
    else v_libre:='NO';
    end if;
    return(v_libre);
  end;  
  
 -------------------------------------------------Ejercicio 5--------------------------------------------------------------------
create or replace function gastodiario(p_habitacion in mumber, p_fecha date) return number is
  v_gasto number(6,2);
  begin
    select sum(precio*cantidad) into v_gasto
    from servicio s join consumir c on c.servicio=codigo
    where p_habitacion=habitacion and p_fecha=fecha;
    return(v_gasto);
  end;  
  
 -------------------------------------------------Ejercicio 6--------------------------------------------------------------------
create or replace function gastototal(p_reserva calendreservas.reserva%type) return number is
  v_gasto number(6,2);
  begin
    select (s.precio*c.cantidad) into v_gasto
    from consumir c join servicio s on servicio = codigo
    join calendreservas r on c.fecha=r.fecha
    where p_reserva=r.reserva and r.habitacion=c.habitacion;
    return(v_gasto);
  end;

-------------------------------------------------Ejercicio 7--------------------------------------------------------------------
create or replace function citasCli(p_tratamiento tratamiento.codigo%type) return number is
  resultado number(5);
  begin
    select count(distinct cliente) into resultado
    from cita
    where p_tratamiento=tratamiento;
    return(resultado);
  end;  

-------------------------------------------------Ejercicio 8--------------------------------------------------------------------
create or replace function empleadoReserva(p_reserva reserva.codigo%type) return varchar is
  v_empleado empleado.nombre%type;
  begin
    select nombre into v_empleado
    from empleado join restelefono on nif=emprecepcion
    where p_reserva=reserva;
    return(v_empleado);
  end;  

-------------------------------------------------Ejercicio 9--------------------------------------------------------------------
select * from calendario;
create or replace function guardiaEmpleado return varchar is
v_empleado empleado.nombre%type;
begin
  cursor guardias is select nombre from empleado, calendario
  where nif=emplimpieza group by nif, nombre
  having count(*) <= all(select count(*) from calendario 
                                          where emplimpieza is not null group by emplimpieza) order by nombre;
    v_empleado empleado.nombre%type;
    contador number(1):=0;
    begin
      for g in guardias loop
        contador:= contador + 1;
        auxnombre:=v_empleado
        if contador=1 then exit;
        end if;
      end loop;
      return(v_empleado);
    end;  

















