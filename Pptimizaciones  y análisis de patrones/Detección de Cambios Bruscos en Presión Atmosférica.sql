WITH presiones_con_previo AS (
    SELECT 
        m1.medicion_id,
        m1.sensor_id,
        m1.fecha_hora,
        m1.valor AS presion_actual,
        (SELECT m2.valor 
         FROM mediciones m2 
         WHERE m2.sensor_id = m1.sensor_id
         AND m2.fecha_hora < m1.fecha_hora
         ORDER BY m2.fecha_hora DESC
         LIMIT 1
        ) AS presion_anterior
    FROM mediciones m1
    JOIN sensores s ON m1.sensor_id = s.sensor_id
    WHERE s.tipo = 'presion'
)

SELECT 
    pc.*,
    pc.presion_actual - pc.presion_anterior AS cambio_presion,
    ABS(pc.presion_actual - pc.presion_anterior) AS cambio_absoluto
FROM presiones_con_previo pc
WHERE pc.presion_anterior IS NOT NULL
AND ABS(pc.presion_actual - pc.presion_anterior) > 5
ORDER BY cambio_absoluto DESC;