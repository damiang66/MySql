/*
1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
*/
select nombre from jugadores order by nombre;
/*
2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.
*/
select nombre,posicion,peso from jugadores where posicion='c' and peso>199 order by nombre;
/*
3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
*/
select nombre from equipos order by nombre;
/*
4. Mostrar el nombre de los equipos del este (East).
*/
select * from equipos where conferencia='east';
/*
Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
*/
select * from equipos where ciudad like 'c%' order by nombre;
/*
6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
*/
select * from jugadores order by nombre_equipo;
/*
7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.

*/
select * from jugadores where Nombre_equipo ='Raptors' order by nombre;
/*
8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
*/
select puntos_por_partido,jugador,temporada from estadisticas where jugador=(select codigo from jugadores where nombre='Pau Gasol');
/*
9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
*/
select puntos_por_partido,jugador,temporada from estadisticas where jugador=(select codigo from jugadores where nombre='Pau Gasol') and temporada='04/05';
/*
10. Mostrar el número de puntos de cada jugador en toda su carrera.
*/
select  (Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido) as Total, jugador from estadisticas group by jugador;
select puntos_por_partido,jugador from estadisticas where jugador=312;
/*
11. Mostrar el número de jugadores de cada equipo.
*/
select count(nombre) as Jugadores_Por_equipos,Nombre_equipo from jugadores group by Nombre_equipo;
/*
12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
*/
-- select  sum(Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido) as Total, jugador  from estadisticas where  sum(Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido)= (select max (sum(Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido)) ;
select (Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido) as Total,jugador from estadisticas where (Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido)=(select max(Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido) from estadisticas) ;
select max(Puntos_por_Partido + Asistencias_por_partido+ Tapones_por_partido+ Rebotes_por_partido) from estadisticas;
/*
13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
*/
select jugadores.nombre, jugadores.Altura, equipos.Conferencia,equipos.Division from jugadores inner join equipos on jugadores.Nombre_equipo=equipos.Nombre where jugadores.Altura = (select max(Altura) from jugadores);
select * from jugadores;
/*
14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
*/
select avg(partidos.puntos_local+partidos.puntos_visitante),equipos.Nombre from partidos inner join equipos as e on partidos.equipo_local=e.Nombre inner join equipos on partidos.equipo_visitante=equipos.Nombre where equipos.Division='Pacific' group by equipos.Nombre;


select * from partidos;
/*
15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.
*/
select * , abs(puntos_local-puntos_visitante) "Diferencia"from partidos where abs(puntos_local-puntos_visitante)= (select max(puntos_local-puntos_visitante) from partidos);
select max(puntos_local-puntos_visitante) from partidos;
/*
16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
*/
-- idem 14 
/*
17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
*/
select  sum(partidos.puntos_local) as Puntos_local, /*, sum(partidos.puntos_visitante) as puntos_visitante,*/ (puntos_visitante+puntos_local)
 as total_puntos,equipos.nombre  from partidos  inner join equipos  on equipos.nombre=equipo_local /*inner join equipos  e on e.nombre=
 equipo_visitante */group by equipos.nombre;
 SELECT equipo_local, puntos_local, equipo_visitante, puntos_visitante FROM partidos;
 -- la que funca
SELECT DISTINCT(e.nombre),
        (SELECT SUM(puntos_local) FROM partidos WHERE equipo_local = e.nombre) as Puntos_local,
        (SELECT SUM(puntos_visitante) FROM partidos WHERE equipo_visitante = e.nombre) as Puntos_visitante
FROM equipos as e;
select sum(puntos_local) from partidos where equipo_local='76ers';
/*
18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.
*/
select * from partidos;

select codigo,equipo_local, equipo_visitante, case when puntos_local>puntos_visitante  then equipo_local when  puntos_local<puntos_visitante  then equipo_visitante else null end as Ganador  from partidos;
-- otra forma
select codigo,equipo_local, equipo_visitante, case when puntos_local>puntos_visitante  then equipo_local when  puntos_local<puntos_visitante  then equipo_visitante  when  puntos_local=puntos_visitante  then null end as Ganador  from partidos;