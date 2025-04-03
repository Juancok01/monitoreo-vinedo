-- Verifica el conteo total 
select count(*)
from mediciones;

-- Distribución por sensor
select sensor_id,
       count(*) as numero_mediciones
from mediciones
group by sensor_id;

-- Muestra las primeras 10 mediciones con detalles del sensor
select m.*,
       s.nombre,
       s.tipo,
       s.ubicacion
from mediciones m
inner join sensores s
on m.sensor_id = s.sensor_id
limit 10;