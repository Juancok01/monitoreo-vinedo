DELIMITER //
CREATE PROCEDURE actualizar_estadisticas_parcela(
    IN p_parcela_id INT
)
BEGIN
    DECLARE v_prom_temp DECIMAL(5,2);
    DECLARE v_prom_humedad DECIMAL(5,2);
    DECLARE v_ultima_actualizacion DATETIME;
    
    -- Calcular promedio de temperatura para la parcela
    SELECT AVG(m.valor) INTO v_prom_temp
    FROM mediciones m
    JOIN sensores s ON m.sensor_id = s.sensor_id
    WHERE s.ubicacion = (SELECT ubicacion FROM parcelas WHERE id = p_parcela_id)
    AND s.tipo = 'temperatura'
    AND m.fecha_hora >= DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    -- Calcular promedio de humedad para la parcela
    SELECT AVG(m.valor) INTO v_prom_humedad
    FROM mediciones m
    JOIN sensores s ON m.sensor_id = s.sensor_id
    WHERE s.ubicacion = (SELECT ubicacion FROM parcelas WHERE id = p_parcela_id)
    AND s.tipo = 'humedad'
    AND m.fecha_hora >= DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    -- Actualizar estadísticas en la tabla parcelas
    UPDATE parcelas
    SET 
        temperatura_promedio = v_prom_temp,
        humedad_promedio = v_prom_humedad,
        ultima_actualizacion = NOW()
    WHERE id = p_parcela_id;
END //
DELIMITER ;