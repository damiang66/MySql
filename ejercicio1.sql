select * from empleados;
select * from departamentos;
select nombre_depto from departamentos;
select nombre,sal_emp from empleados;
select comision_emp from empleados;
select * from empleados where cargo_emp='Secretaria';
select * from empleados where cargo_emp='Vendedor'order by nombre asc;
select nombre,cargo_emp, sal_emp as salario from empleados order by sal_emp;
select empleados.nombre, departamentos.ciudad from empleados INNER JOIN departamentos on empleados.id_depto = departamentos.id_depto  where cargo_emp like '%Jefe%' and departamentos.ciudad='ciudad real';
select nombre as Nombre, cargo_emp as Cargo from empleados;
select sal_emp, comision_emp from empleados where id_depto=2000 order by comision_emp;
/*
12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
 empleado y el total a pagar, en orden alfabético.*/
 select nombre, sal_emp, comision_emp,(sal_emp + comision_emp + 500) as Salario_Total from empleados where id_depto=3000 order by nombre;
/*
13. Muestra los empleados cuyo nombre empiece con la letra J.
*/
select * from empleados where nombre like 'j%';
/*
14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
empleados que tienen comisión superior a 1000.
*/
select sal_emp, comision_emp,(sal_emp + comision_emp) as Salario_Total, nombre from empleados where comision_emp>1000;
/*
15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión.
*/
select sal_emp, comision_emp,(sal_emp + comision_emp) as Salario_Total, nombre from empleados where comision_emp=0;
/*
16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
*/
select * from empleados where sal_emp<comision_emp;
/*
17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
*/
select nombre,(sal_emp * 0.30) as porcentaje , comision_emp, sal_emp from empleados  where comision_emp<=(sal_emp * 0.30);
/*
18. Hallar los empleados cuyo nombre no contiene la cadena “MA”
*/
select nombre from empleados where nombre not like '%ma%';
/*
19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento.
*/
select * from departamentos where nombre_depto='VENTAS' OR nombre_depto='INVESTIGACION' OR nombre_depto='MANTENIMIENTO';
/*
20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.
*/
select * from departamentos where NOT (nombre_depto='VENTAS' OR nombre_depto='INVESTIGACION' OR nombre_depto='MANTENIMIENTO');
/*
21. Mostrar el salario más alto de la empresa.
*/
select  max(sal_emp) as salarioAlto, nombre  from empleados where sal_emp= (SELECT Max(sal_emp) from empleados);
select nombre from empleados where sal_emp=6250000;
/*
22. Mostrar el nombre del último empleado de la lista por orden alfabético.
*/
select nombre from empleados order by nombre asc;
select nombre from empleados  where nombre= (SELECT Max(nombre) from empleados);
select nombre from empleados;
/*
23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
*/
select max(sal_emp) as maximo, min(sal_emp) as minimo,max(sal_emp)- min(sal_emp) as diferencia from empleados ;

/*where sal_emp=(select max(sal_emp) from empleados) and sal_emp=(select min(sal_emp) from empleados)*/
/*
24. Hallar el salario promedio por departamento.
*/
select avg(sal_emp) as salario_promedio, empleados.id_depto,departamentos.nombre_depto, departamentos.ciudad from empleados inner join departamentos on empleados.id_depto=departamentos.id_depto group by empleados.id_depto;
select avg(sal_emp) as salario_promedio, id_depto,cargo_emp from empleados group by id_depto;
select * from empleados;
/*
SELECT COUNT(ID), pais FROM Personas GROUP BY pais HAVING COUNT(ID) > 1;
25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos.
*/
select count(id_depto),id_depto from empleados group by id_depto having count(id_depto)>3;
/*
26. Hallar los departamentos que no tienen empleados
*/
select count(id_depto),id_depto from empleados group by id_depto having count(id_depto)=1;
select * from empleados where id_depto=4300;
/*
27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada
departamento. VERRRRRRRRRRRRRRRRRRRRRR
*/
select nombre, nombre_depto, cod_director from empleados inner join departamentos on empleados.id_depto = departamentos.id_depto;
select nombre as Director from empleados inner join departamentos on departamentos.cod_director= empleados.cod_jefe;
/*
28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento. VERRRRRRRRRRRRRRRRRRRRRR*/
select * from empleados  inner join departamentos on empleados.id_depto= departamentos.id_depto where sal_emp>=(select avg(sal_emp) from empleados) order by nombre_depto;