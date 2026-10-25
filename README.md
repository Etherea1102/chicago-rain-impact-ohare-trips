# Impacto de la lluvia en los tiempos de viaje al aeropuerto O'Hare (Chicago)

## Contexto
Análisis para Zuber, una plataforma de viajes compartidos que se lanza en Chicago. El objetivo fue entender los patrones de viaje de los pasajeros y evaluar si el clima afecta la duración de los trayectos al aeropuerto, información útil para planificar la flota.

## Preguntas
1. ¿Qué empresas de taxis concentran el mercado?
2. ¿Cuáles son los principales barrios de destino?
3. ¿La lluvia cambia la duración de los viajes del Loop al aeropuerto O'Hare los sábados?

## Qué hice
- Extraje los datos con consultas SQL y web scraping de datos meteorológicos (en la plataforma de TripleTen); este notebook contiene el análisis en Python.
- Verifiqué tipos de datos y valores nulos en los datasets de empresas (64) y barrios (94).
- Identifiqué el top 10 de empresas y de barrios de destino, con visualizaciones en Seaborn.
- Planteé y probé una hipótesis sobre el efecto del clima en la duración de los viajes.

## Decisiones
- Comparé los viajes de sábados con buen clima vs. sábados lluviosos, para aislar el efecto del clima del día de la semana.
- Usé una prueba t de Welch (`equal_var=False`) porque no podía asumir que las varianzas de ambos grupos fueran iguales.
- Nivel de significancia: α = 0.05.
- Mejora identificada: aplicar primero la prueba de Levene para verificar formalmente la igualdad de varianzas.

## Resultados
- **Flash Cab** lidera el mercado con casi 20,000 viajes en dos días (15–16 nov. 2017), casi el doble que su siguiente competidor.
- **Loop y River North** son los principales destinos, lo que confirma la concentración de viajes en zonas comerciales y turísticas.
- **La lluvia aumenta en 21% la duración de los viajes a O'Hare** (de ~33 a ~40 minutos en promedio; p-value = 6.74 × 10⁻¹²). Se rechaza la hipótesis nula.

## Herramientas
Python · pandas · SciPy · Matplotlib · Seaborn · SQL

## Cómo verlo
Abre `chicago_rain_impact_ohare.ipynb`: GitHub lo muestra con todos los resultados y gráficos. 
