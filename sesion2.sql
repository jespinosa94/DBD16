   
   select * from camara;
   ---------------------------------1 a 5---------------------------------------
   select email, nombre, apellidos from usuario order by apellidos, nombre;
   
   select provincia.* from provincia join usuario on codp = provincia;
   
   select distinct codp, p.nombre from provincia p join usuario on codp = provincia order by nombre;
   
   select * from articulo where marca is null;
   
   select email, 'No tiene telefono' from usuario join provincia on provincia = codp where provincia.nombre = 'Murcia' and telefono is null;

   ---------------------------------6 a 10--------------------------------------
   
   select fecha, usuario, a.cod, nombre, marca, pvp, importe
   from linped l join pedido p on l.numpedido = p.numpedido
   join articulo a on l.articulo = a.cod
   join tv on a.cod = tv.cod
   where l.numpedido = 1;
   
   select email from usuario where codpos not in ('02012', '02018', '02032');
   
   select numpedido, fecha, nombre, apellidos from pedido p join usuario u on p.usuario = email
   where apellidos like '%MARTINEZ%';
   
   select cod, nombre, marca, pvp 
   from articulo 
   where pvp = (select max(pvp) from articulo);
   
   select c.cod, nombre, pvp from camara c join articulo a on c.cod = a.cod
   where tipo like '%réflex%' and pvp = 
   (select max(pvp) from articulo a join camara c on a.cod = c.cod
   where tipo like '%réflex%');  ---Hay que repetir el like porque sino estaría buscando el pvp maximo entre todas las camaras?---
   
   
   ---------------------------------11 a 16--------------------------------------
   select marca from marca 
   where marca not in 
   (select marca from articulo a join tv on a.cod = tv.cod);
   
   select a.cod, nombre, tipo, marca from articulo a join camara c on a.cod = c.cod
   where a.marca in ('Nikon', 'LG', 'SIGMA');
   
   select a.cod, nombre, resolucion, sensor from articulo a left join camara c on a.cod = c.cod;
   
   select c.*, nombre, pvp from cesta c join articulo a on c.articulo = a.cod
   where to_char(fecha, 'YYYY') = '2010';
   
   select * from articulo a left join cesta c on a.cod = c.articulo and to_char(fecha, 'yyyy') = '2010';
   
   select count(*) usuarios from usuario;
   
   ---------------------------------17 a 22--------------------------------------
   
   select count(distinct provincia), 'provincias con usuario' from usuario;
   
   select max(pantalla) from tv;
   
   select min(nacido) from usuario;
   
   select * from linped;
   
   select linea, articulo, (importe*cantidad) total from linped where numpedido = 1;
   
   select p.numpedido, fecha, nombre, apellidos from pedido p join usuario u on p.usuario = u.email
   join linped l on p.numpedido = l.numpedido
   where (cantidad * importe) = (select max(importe*cantidad) from linped);
   
   ---------------------------------23 a 28--------------------------------------
   
   select dni, nombre, apellidos, email, count(*) numpedidos 
   from usuario u join pedido p 
   on u.email = p.usuario
   group by dni, nombre, apellidos, email
   having count(*) > 1;
   
   select p.numpedido, p.usuario, count(distinct articulo) articulos 
   from pedido p join linped l on p.numpedido = l.numpedido
   group by p.numpedido, usuario
   having count(distinct articulo) > 4;
   
   select codp, p.nombre, count(email) usuarios
   from provincia p join usuario u on codp = u.provincia
   group by codp, p.nombre
   having count(*) > 50;
   
   select count(*) from articulo a
   where cod not in (select cod from memoria)
   and cod not in (select cod from tv)
   and cod not in (select cod from objetivo)
   and cod not in (select cod from camara)
   and cod not in (select cod from pack);
   
   select cod, nombre, count(distinct numpedido) veces 
   from articulo left join linped on cod = articulo
   group by cod, nombre;
   
   select p.numpedido, usuario, sum(cantidad*importe) total 
   from pedido p join linped l on p.numpedido = l.numpedido
   group by p.numpedido, usuario
   having sum(cantidad * importe) > 4000;
   
    ---------------------------------29 a 33--------------------------------------
   
   select distinct cod, marca, pvp 
   from articulo a
   where marca = 'Samsung'
   and pvp is not null
   and a.cod not in (select articulo from linped);
  
   select cod 
   from articulo 
   where cod in (select articulo from cesta)
   or cod in (select articulo from linped);
   
   select email, nombre 
   from usuario 
   where email not in (select usuario from pedido)
   union
   select email, nombre
   from usuario join pedido on email = usuario 
   group by email, nombre
   having count(*) = 1;
   
   select email, nombre 
   from usuario 
   where email not in 
   (select usuario 
   from pedido p join linped l on p.numpedido = l.numpedido
   join camara c on c.cod = l.articulo);
   
   select sysdate 
   from dual;
   
   
   
   
   
   
   
