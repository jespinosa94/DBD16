   
   select * from usuario;
   ---------------------------------1 a 5---------------------------------------
   select email, nombre, apellidos from usuario order by apellidos, nombre;
   
   select provincia.* from provincia join usuario on codp = provincia;
   
   select distinct codp, p.nombre from provincia p join usuario on codp = provincia order by nombre;
   
   select * from articulo where marca is null;
   
   select email, 'No tiene telefono' from usuario join provincia on provincia = codp where provincia.nombre = 'Murcia' and telefono is null;

   ---------------------------------6 a 10---------------------------------------
   select fecha, usuario from pedido where numPedido = 1 union all --revisar a partir de aqui--
   select a.cod, a.nombre, a.marca, a.pvp, importe from pedido p
   join linped l on p.numPedido = l.numPedido
   join articulo a on a.cod = l.articulo
   join tv on a.cod = tv.cod
   where l.numPedido = 1;
   
   
   select fecha, usuario, a.cod, nombre, marca, pvp, importe
   from linped l join pedido p on l.numpedido = p.numpedido
   join articulo a on l.articulo = a.cod
   join tv on a.cod = tv.cod
   where l.numpedido = 1;
   
   
   
   
   
   
   
   
   
   
   
