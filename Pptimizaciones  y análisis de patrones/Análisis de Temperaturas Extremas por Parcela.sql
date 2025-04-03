-- Análisis de Temperaturas Extremas por Parcela
WITH temp_stats AS (
    SELECT 
        s.ubicacion,
        AVG(m.valor) AS promedio,
        STDDEV(m.valor) AS desviacion
    FROM mediciones m
    JOIN sensores s ON m.sensor_id = s.sensor_id
    WHERE s.tipo = 'temperatura'
    GROUP BY s.ubicacion
)
SELECT 
    m.medicion_id,
    s.ubicacion,
    m.valor AS temperatura,
    ts.promedio,
    ts.desviacion,
    CASE
        WHEN m.valor > ts.promedio + (2 * ts.desviacion) THEN 'Alta extrema'
        WHEN m.valor < ts.promedio - (2 * ts.desviacion) THEN 'Baja extrema'
        ELSE 'Normal'
    END AS clasificacion
FROM mediciones m
JOIN sensores s ON m.sensor_id = s.sensor_id
JOIN temp_stats ts ON s.ubicacion = ts.ubicacion
WHERE s.tipo = 'temperatura'
ORDER BY ABS(m.valor - ts.promedio) DESC;
        
                                           
