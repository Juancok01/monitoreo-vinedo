DELIMITER //
CREATE TRIGGER validar_medicion_antes_insertar
BEFORE INSERT ON mediciones
FOR EACH ROW
BEGIN
    DECLARE v_tipo_sensor VARCHAR(30);
    DECLARE v_valor_min DECIMAL(10,2);
    DECLARE v_valor_max DECIMAL(10,2);
    
    -- Obtener tipo de sensor y rangos válidos
    SELECT tipo INTO v_tipo_sensor
    FROM sensores
    WHERE sensor_id = NEW.sensor_id;
    
    -- Establecer rangos según tipo de sensor
    CASE v_tipo_sensor
        WHEN 'temperatura' THEN 
            SET v_valor_min = -20.00, v_valor_max = 50.00;
        WHEN 'humedad' THEN 
            SET v_valor_min = 0.00, v_valor_max = 100.00;
        WHEN 'presion' THEN 
            SET v_valor_min = 950.00, v_valor_max = 1050.00;
        WHEN 'calidad_aire' THEN 
            SET v_valor_min = 0.00, v_valor_max = 500.00;
        ELSE
            SET v_valor_min = NULL, v_valor_max = NULL;
    END CASE;
    
    -- Validar rango
    IF v_valor_min IS NOT NULL AND (NEW.valor < v_valor_min OR NEW.valor > v_valor_max) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor fuera de rango para este tipo de sensor';
    END IF;
END //
DELIMITER ;