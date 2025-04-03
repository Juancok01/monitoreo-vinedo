import csv
import random
from datetime import datetime, timedelta

def generar_sensores():
    tipos = ['temperatura', 'humedad', 'presion', 'calidad_aire']
    ubicaciones = ['Parcela Norte', 'Parcela Sur', 'Parcela Este', 'Parcela Oeste', 'Bodega']
    
    with open('sensores.csv', 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['sensor_id', 'nombre', 'tipo', 'ubicacion', 'fecha_instalacion', 'activo'])
        
        for i in range(1, 11):  # 10 sensores
            writer.writerow([
                i,
                f'VIÑ-{random.randint(100,999)}-{random.choice(["A","B","C"])}',
                random.choice(tipos),
                random.choice(ubicaciones),
                (datetime.now() - timedelta(days=random.randint(30, 365))).strftime('%Y-%m-%d'),
                random.choices([True, False], weights=[0.8, 0.2])[0]
            ])

def generar_mediciones():
    with open('mediciones.csv', 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['medicion_id', 'sensor_id', 'fecha_hora', 'valor'])
        
        medicion_id = 1
        mediciones_por_sensor = 50  # 10 sensores × 50 = 500 mediciones
        
        for sensor_id in range(1, 11):
            for _ in range(mediciones_por_sensor):
                # Generar fecha en los últimos 30 días
                fecha_hora = (datetime.now() - timedelta(
                    minutes=random.randint(1, 60*24*30))).strftime('%Y-%m-%d %H:%M:%S')
                
                # Generar valores realistas según tipo de sensor
                if sensor_id % 4 == 1:  # Temperatura (0-40°C)
                    hora = int(fecha_hora[11:13])
                    base_temp = 10 + 10 * (hora/24)  # Variación diurna
                    valor = round(base_temp + random.uniform(-5, 5), 2)
                elif sensor_id % 4 == 2:  # Humedad (20-95%)
                    valor = round(50 + 45 * random.random(), 2)
                elif sensor_id % 4 == 3:  # Presión (980-1040 hPa)
                    valor = round(1010 + random.uniform(-30, 30), 2)
                else:  # Calidad aire (0-500)
                    valor = round(random.uniform(0, 500), 2)
                
                writer.writerow([medicion_id, sensor_id, fecha_hora, valor])
                medicion_id += 1

if __name__ == "__main__":
    print("Generando archivos CSV...")
    generar_sensores()
    generar_mediciones()
    print("¡Archivos generados exitosamente!")
    print(" - sensores.csv (10 sensores)")
    print(" - mediciones.csv (500 mediciones totales, 50 por sensor)")