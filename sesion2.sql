   
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
   where tipo like '%r�flex%' and pvp = 
   (select max(pvp) from articulo a join camara c on a.cod = c.cod
   where tipo like '%r�flex%');  ---Hay que repetir el like porque sino estar�a buscando el pvp maximo entre todas las camaras?---
   
   
   ---------------------------------11 a 16--------------------------------------
   select * from marca;
   select marca from marca 
   where marca not in 
   (select marca from articulo a join tv on a.cod = tv.cod);
   
   
   
   
   
   
   
   
   
   