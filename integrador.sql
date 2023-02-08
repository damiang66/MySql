-- candado A
-- 1
select count(Asistencias_por_partido) from estadisticas where 
Asistencias_por_partido=(select max(Asistencias_por_partido)from estadisticas);

-- 2
select sum(j.peso) as peso from jugadores j inner join equipos e on e.nombre= j.Nombre_equipo where e.Conferencia = 'East'and j.posicion like '%c%';
-- (2,14043)
-- candado b
-- 1
select count(*) from estadisticas where Asistencias_por_partido> (select count(*) from jugadores where Nombre_equipo='heat');
-- 2
select count(*) from partidos where temporada like'%99%';
-- [3, 3480]
-- candado c
-- 1 
select  count(*)  from jugadores as j  inner join equipos as e on j.Nombre_equipo =e.nombre where  j.procedencia like'%Michigan%'and e.conferencia='West' ;
select count( * ) from jugadores where peso>=195;

-- 2
select floor (avg(puntos_por_partido) + count(Asistencias_por_partido) + sum(Tapones_por_partido)) from estadisticas inner join jugadores on jugadores.codigo= estadisticas.jugador inner join equipos on jugadores.Nombre_equipo= equipos.Nombre where equipos.Division='Central';
-- [1, 631]
-- candado D
-- 1 
select round(estadisticas.Tapones_por_partido) from estadisticas inner join jugadores on jugadores.codigo= estadisticas.jugador where jugadores.Nombre='Corey Maggette' and estadisticas.temporada='00/01';
select floor(sum(estadisticas.puntos_por_partido)) from estadisticas inner join jugadores on jugadores.codigo= estadisticas.jugador where jugadores.Procedencia='Argentina';

-- [4, 191]