/*
1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
*/
select codigo_oficina, ciudad from oficina;
/*
2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
*/
select ciudad, telefono from oficina where pais='españa';
/*
3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
código de jefe igual a 7.
*/
select nombre, concat(apellido1 , apellido2)as Apellido, email from  empleado where codigo_jefe=7;
/*
4-Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
*/
select puesto, nombre, apellido1, email from empleado where  puesto='director general';
/*
5-Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas.
*/
select nombre, apellido1, puesto from empleado where puesto not in ('representante ventas');
/*
6. Devuelve un listado con el nombre de los todos los clientes españoles.
*/
select nombre_cliente, pais from cliente where pais in ('spain');
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select estado from pedido group by estado;
/*
8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores.
*/
select codigo_cliente, fecha_pago from pago where year(fecha_pago)='2008' group by codigo_cliente; 
select codigo_cliente, date_format(fecha_pago,'%d -  %m  - %Y') as Fecha_pago from pago  where fecha_pago like '%2008%' group by codigo_cliente ;
select codigo_cliente, fecha_pago from pago where fecha_pago like '%2008%'group by codigo_cliente;
/*
DATE_FORMAT(orderdate, '%Y-%m-%d') orderDate,
    DATE_FORMAT(requireddate, '%a %D %b %Y') requireddate,
    DATE_FORMAT(shippedDate, '%W %D %M %Y') shippedDate
    */
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos que no han sido entregados a tiempo.    
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_entrega> fecha_esperada;
/*
10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL.
*/
select codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega, datediff(fecha_esperada,fecha_entrega) as diferencia from pedido where datediff(fecha_esperada,fecha_entrega)>1; 
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select codigo_cliente, estado, fecha_pedido from pedido where estado='rechazado' and year(fecha_pedido) like '%2009%';
/*Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año.*/
select codigo_cliente, estado, fecha_pedido from pedido where estado='entregado' and date_format(fecha_pedido,'%m -  %d  - %Y')  like '01%';
/*
13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor.
*/
select forma_pago, total from pago where forma_pago ='PayPal' and Year(fecha_pago) like '%2008%' order by total desc;
/*
14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.
*/
select forma_pago from pago group by forma_pago;
/*
15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio.
*/
select * from producto where gama='Ornamentales' and cantidad_en_stock>100 order by precio_venta desc;
/*
16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.
*/
select * from cliente where ciudad='madrid' and codigo_empleado_rep_ventas in (11,30);
/*
Consultas multitabla (Composición interna)
Las consultas se deben resolver con INNER JOIN.
*/
/*1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
de ventas.*/
select cliente.nombre_cliente as cliente, empleado.nombre, empleado.apellido1,empleado.codigo_empleado, cliente.codigo_empleado_rep_ventas from cliente inner join empleado on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado where empleado.puesto = 'Representante Ventas';
/*
2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.
*/
select cliente.codigo_cliente as cliente, cliente.nombre_cliente as cliente, empleado.nombre, empleado.apellido1,empleado.codigo_empleado, cliente.codigo_empleado_rep_ventas,pago.codigo_cliente as pago from cliente inner join empleado on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado inner join pago on pago.codigo_cliente=cliente.codigo_cliente where empleado.puesto = 'Representante Ventas';
/*
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas.
*/
-- NOOOOO FUNCIONA
select codigo_cliente;
select cliente.codigo_cliente,pago.codigo_cliente,cliente.codigo_empleado_rep_ventas, empleado.nombre from cliente inner join empleado on  cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado left outer join pago on cliente.codigo_cliente=pago.codigo_cliente where pago.codigo_cliente is null ;
/*
4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.
*/
select cliente.codigo_cliente,pago.codigo_cliente,cliente.codigo_empleado_rep_ventas, empleado.nombre, oficina.ciudad from empleado inner join cliente on  cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado inner join pago on cliente.codigo_cliente=pago.codigo_cliente inner join oficina on oficina.codigo_oficina= empleado.codigo_oficina where pago.codigo_cliente =cliente.codigo_cliente ;
/*
5-Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.
*/
select cliente.codigo_cliente,pago.codigo_cliente,cliente.codigo_empleado_rep_ventas, empleado.nombre, oficina.ciudad from empleado inner join cliente on  cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado left outer join pago on cliente.codigo_cliente=pago.codigo_cliente inner join oficina on oficina.codigo_oficina= empleado.codigo_oficina where pago.codigo_cliente is null ;
/*
6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada. 
*/
select oficina.linea_direccion1,cliente.codigo_cliente,cliente.linea_direccion2 from oficina inner join empleado on oficina.codigo_oficina= empleado.codigo_oficina inner join cliente on cliente.codigo_cliente=empleado.codigo_empleado where cliente.linea_direccion2='Fuenlabrada';
/*
7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante.
*/
select cliente.nombre_cliente, empleado.nombre ,oficina.ciudad from empleado inner join oficina on oficina.codigo_oficina=empleado.codigo_oficina inner join cliente on cliente.codigo_cliente= empleado.codigo_empleado;
/*
8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
*/
-- VER no funca
select empleado.codigo_empleado, empleado.nombre,(empleado.codigo_jefe),  case when empleado.codigo_jefe = e.codigo_jefe then e.nombre end as Nombre_Jefe from empleado inner join empleado e on empleado.codigo_jefe=e.codigo_jefe where empleado.codigo_jefe=e.codigo_jefe ;
 /*
 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
 */
 select cliente.nombre_cliente from cliente inner join pedido on pedido.codigo_cliente=cliente.codigo_cliente where pedido.fecha_entrega>pedido.fecha_esperada;
 /*
 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
 */
 select producto.gama, cliente.codigo_cliente from producto inner join detalle_pedido on detalle_pedido.codigo_producto = producto.codigo_producto inner join pedido on pedido.codigo_pedido= detalle_pedido.codigo_pedido inner join cliente on pedido.codigo_cliente=cliente.codigo_cliente   order by cliente.codigo_cliente; 
 /*
				Consultas multitabla (Composición externa)
					Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
 */
 -- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
 select cliente.codigo_cliente from cliente left outer join pago on pago.codigo_cliente=cliente.codigo_cliente where pago.codigo_cliente is null;
 /*
 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pedido.
 */
 select cliente.codigo_cliente from cliente left outer join pedido on pedido.codigo_cliente=cliente.codigo_cliente where pedido.codigo_cliente is null;
/*
 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
no han realizado ningún pedido.
*/
select cliente.codigo_cliente from cliente left outer join pedido on pedido.codigo_cliente=cliente.codigo_cliente  left outer join pago on pago.codigo_cliente=cliente.codigo_cliente where pedido.codigo_cliente is null and pago.codigo_cliente is null;
/*
4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
asociada.
*/
-- ver TODOS LOS EMPLEADOS TIENEN OFICINA
select empleado.codigo_empleado from empleado left outer join oficina on oficina.codigo_oficina= empleado.codigo_oficina where empleado.codigo_oficina is null;
/*5-devuelve un listado que muestre solamente los empleados que no tienen un cliente
asociado.*/
select empleado.codigo_empleado, cliente.codigo_empleado_rep_ventas from empleado left outer join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado where cliente.codigo_empleado_rep_ventas is null;
/*
6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado.
*/ 
-- NO SE PUEDE REALIZAR PORQUE TODOS LOS EMPLEADOS TIENEN UNA OFICINA ASOCIADA
/*
7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
*/
select producto.nombre, producto.codigo_producto,detalle_pedido.codigo_producto from producto left outer join  detalle_pedido on detalle_pedido.codigo_producto=producto.codigo_producto where detalle_pedido.codigo_producto is null;
/*
8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.
*/
/*
9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago.
*/
select cliente.codigo_cliente, cliente.nombre_contacto,pago.codigo_cliente from cliente inner join pedido on pedido.codigo_cliente=cliente.codigo_cliente left outer join pago on pago.codigo_cliente=cliente.codigo_cliente where pago.codigo_cliente is null; 
/*
10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.
*/
select empleado.codigo_empleado, empleado.nombre from empleado left outer join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado where cliente.codigo_empleado_rep_ventas is null;
-- Consultas resumen
-- 1. ¿Cuántos empleados hay en la compañía?
select count(codigo_empleado) from empleado;
-- 2. ¿Cuántos clientes tiene cada país?
select count(codigo_cliente),pais from cliente group by pais;
-- 3. ¿Cuál fue el pago medio en 2009?
select avg(total) as promedio from pago where year(fecha_pago)like '2009';
-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
select estado,count(codigo_pedido) from pedido group by estado order by codigo_pedido desc ;
-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select max(precio_venta), min(precio_venta) from producto;
-- 6. Calcula el número de clientes que tiene la empresa.
select count(codigo_cliente) from cliente;
-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
select count(codigo_cliente) from cliente where ciudad='madrid';
-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select count(codigo_cliente) from cliente where ciudad like'm%';
-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
