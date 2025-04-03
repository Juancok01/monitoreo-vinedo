DELIMITER //
CREATE PROCEDURE registrar_alerta_temperatura(
    IN p_sensor_id INT,
    IN p_umbral_superior DECIMAL(5,2),
    IN p_umbral_inferior DECIMAL(5,2)
)
BEGIN
    DECLARE v_ultima_temp DECIMAL(5,2);
    DECLARE v_ubicacion VARCHAR(100);
    DECLARE v_tipo_alerta VARCHAR(50);
    
    -- Obtener última temperatura y ubicación
    SELECT m.valor, s.ubicacion INTO v_ultima_temp, v_ubicacion
    FROM mediciones m
    JOIN sensores s ON m.sensor_id = s.sensor_id
    WHERE m.sensor_id = p_sensor_id
    AND s.tipo = 'temperatura'
    ORDER BY m.fecha_hora DESC
    LIMIT 1;
    
    -- Determinar tipo de alerta si corresponde
    IF v_ultima_temp > p_umbral_superior THEN
        SET v_tipo_alerta = 'TEMPERATURA_ALTA';
    ELSEIF v_ultima_temp < p_umbral_inferior THEN
        SET v_tipo_alerta = 'TEMPERATURA_BAJA';
    END IF;
    
    -- Registrar alerta si se superó algún umbral
    IF v_tipo_alerta IS NOT NULL THEN
        INSERT INTO alertas (sensor_id, tipo_alerta, descripcion, fecha_hora)
        VALUES (
            p_sensor_id,
            v_tipo_alerta,
            CONCAT('Temperatura ', v_ultima_temp, '°C en ', v_ubicacion),
            NOW()
        );
    END IF;
END //
DELIMITER ;