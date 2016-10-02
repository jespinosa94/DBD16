   
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
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
