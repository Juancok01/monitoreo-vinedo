WITH humedad_diurna AS (
    SELECT 
        sensor_id,
        AVG(valor) AS promedio_diurno
    FROM mediciones
    WHERE HOUR(fecha_hora) BETWEEN 6 AND 18
    GROUP BY sensor_id
),
humedad_nocturna AS (
    SELECT 
        sensor_id,
        AVG(valor) AS promedio_nocturno
    FROM mediciones
    WHERE HOUR(fecha_hora) < 6 OR HOUR(fecha_hora) > 18
    GROUP BY sensor_id
)

SELECT 
    s.sensor_id,
    s.ubicacion,
    hd.promedio_diurno,
    hn.promedio_nocturno,
    hd.promedio_diurno - hn.promedio_nocturno AS diferencia
FROM sensores s
JOIN humedad_diurna hd ON s.sensor_id = hd.sensor_id
JOIN humedad_nocturna hn ON s.sensor_id = hn.sensor_id
WHERE s.tipo = 'humedad'
ORDER BY diferencia DESC;