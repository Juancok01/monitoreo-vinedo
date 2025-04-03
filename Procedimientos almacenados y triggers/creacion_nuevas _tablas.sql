CREATE TABLE alertas (
    alerta_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    tipo_alerta VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resuelta BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sensor_id) REFERENCES sensores(sensor_id)
);


CREATE TABLE parcelas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(100) NOT NULL,
    variedad_uva VARCHAR(50),
    temperatura_promedio DECIMAL(5,2),
    humedad_promedio DECIMAL(5,2),
    ultima_actualizacion DATETIME
);

CREATE TABLE auditoria_mediciones (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    medicion_id INT,
    sensor_id INT,
    valor_anterior DECIMAL(10,2),
    valor_nuevo DECIMAL(10,2),
    usuario VARCHAR(50),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP
);