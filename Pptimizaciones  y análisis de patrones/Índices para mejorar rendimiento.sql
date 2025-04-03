CREATE INDEX idx_mediciones_sensor_fecha ON mediciones(sensor_id, fecha_hora);
CREATE INDEX idx_sensores_tipo ON sensores(tipo);
CREATE INDEX idx_sensores_ubicacion ON sensores(ubicacion);