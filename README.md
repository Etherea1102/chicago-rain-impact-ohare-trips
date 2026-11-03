# Impacto de la lluvia en los tiempos de viaje al aeropuerto O'Hare | Python, SQL y SciPy

**Resumen:** la lluvia aumenta en 21% la duración de los viajes del centro al aeropuerto O'Hare los sábados (~40 vs. ~33 minutos), y el mercado de taxis está concentrado: Flash Cab hace casi el doble de viajes que su siguiente competidor.

<img width="964" height="394" alt="Top 10 empresas de taxis por número de viajes" src="https://github.com/user-attachments/assets/ba76602c-334a-427c-a4a2-077955b6c449" />



## Contexto y pregunta de negocio
Zuber, una plataforma de viajes compartidos, se lanzaba en Chicago y necesitaba entender los patrones de viaje de los pasajeros. ¿Qué empresas y destinos concentran la demanda? ¿Cambia la duración de los viajes al aeropuerto cuando llueve? Esto es clave para planificar flotas y estimar tiempos de llegada.

## Datos
- **Fuente:** base de datos de viajes en taxi de Chicago y datos meteorológicos extraídos por web scraping, provistos por la plataforma de TripleTen.
- **Período:** noviembre de 2017.
- **Variables principales:** empresa de taxis, número de viajes, barrio de destino, duración del viaje (segundos) y condiciones climáticas (buenas/malas).
- **Limitaciones:** el análisis de clima se restringe a viajes de sábados entre el Loop y O'Hare. Los CSV de origen eran resultados de consultas en la plataforma y no se incluyen en el repositorio.

## Metodología y herramientas
1. **SQL:** extracción y agregación de datos de viajes y clima (ver `consultas_sql.sql`).
2. **Web scraping** de condiciones meteorológicas con BeautifulSoup.
3. **Python:** verificación de tipos y nulos, top 10 de empresas y barrios, y visualizaciones con Seaborn.
4. **Prueba de hipótesis:** comparación de la duración media de los viajes en sábados con buen y mal clima.

**Decisiones:**
- Comparé solo sábados, para aislar el efecto del clima del día de la semana.
- Usé la prueba t de Welch (`equal_var=False`) porque no podía asumir varianzas iguales entre los grupos (α = 0.05).
- Mejora identificada: aplicar primero la prueba de Levene para verificar formalmente la igualdad de varianzas.

## Hallazgos principales
- **La lluvia aumenta en 21% la duración de los viajes a O'Hare** (p-value = 6.74 × 10⁻¹²): se rechaza la hipótesis nula.
- **Flash Cab** concentra casi 20,000 viajes en dos días, casi el doble que su siguiente competidor.
- **Loop y River North** son los principales destinos, lo que refleja la concentración de la demanda en zonas comerciales y turísticas.

## Recomendación
Ajustar los tiempos estimados de llegada y la asignación de conductores en días de lluvia, y sugerir a los pasajeros más margen para viajes al aeropuerto. Como siguiente paso, convendría validar el patrón con más meses y otros días de la semana.

## Evidencia técnica
- 📓 Notebook: [`chicago_rain_impact_ohare.ipynb`](chicago_rain_impact_ohare.ipynb)
- 🗄️ Consultas SQL: [`consultas_sql.sql`](consultas_sql.sql)
