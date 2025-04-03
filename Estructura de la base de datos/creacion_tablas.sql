CREATE TABLE IF NOT EXISTS sensores (
	sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    fecha_instalacion DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE);
    
 CREATE TABLE IF NOT EXISTS mediciones ( 
	medicion_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sensor_id) REFERENCES sensores(sensor_id)
    );
 



