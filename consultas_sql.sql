-- =====================================================================
-- Proyecto: Impacto de la lluvia en los viajes al aeropuerto O'Hare
-- Consultas SQL sobre la base de datos de taxis de Chicago
-- (plataforma de TripleTen). Motor: PostgreSQL.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. Número de viajes por empresa de taxis (15 y 16 de noviembre de 2017)
--    Resultado usado en el notebook: project_sql_result_01.csv
-- ---------------------------------------------------------------------
SELECT 
    cabs.company_name AS company_name, 
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
    INNER JOIN trips ON cabs.cab_id = trips.cab_id
WHERE 
    CAST(trips.start_ts AS date) BETWEEN '2017-11-15' AND '2017-11-16'
GROUP BY 
    company_name
ORDER BY 
    trips_amount DESC;


-- ---------------------------------------------------------------------
-- 2. Viajes de empresas con "Yellow" o "Blue" en el nombre
--    (1 al 7 de noviembre de 2017)
-- ---------------------------------------------------------------------
SELECT 
    cabs.company_name, 
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
    INNER JOIN trips ON cabs.cab_id = trips.cab_id
WHERE 
    (cabs.company_name LIKE '%Yellow%' OR cabs.company_name LIKE '%Blue%')
    AND CAST(trips.start_ts AS date) BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY 
    cabs.company_name;


-- ---------------------------------------------------------------------
-- 3. Viajes de las dos empresas líderes frente al resto del mercado
--    (1 al 7 de noviembre de 2017)
-- ---------------------------------------------------------------------
SELECT 
    CASE
        WHEN cabs.company_name = 'Flash Cab' THEN 'Flash Cab'
        WHEN cabs.company_name = 'Taxi Affiliation Services' THEN 'Taxi Affiliation Services'
        ELSE 'Other'
    END AS company,
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
    INNER JOIN trips ON cabs.cab_id = trips.cab_id
WHERE 
    CAST(trips.start_ts AS date) BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY 
    company
ORDER BY 
    trips_amount DESC;


-- ---------------------------------------------------------------------
-- 4. Identificadores de los barrios Loop y O'Hare
--    (necesarios para filtrar la ruta en la consulta 6)
-- ---------------------------------------------------------------------
SELECT 
    neighborhood_id,
    name
FROM 
    neighborhoods
WHERE
    name LIKE '%Hare' OR name LIKE 'Loop';


-- ---------------------------------------------------------------------
-- 5. Clasificación de los registros meteorológicos por hora
--    'Bad' si la descripción incluye lluvia (rain) o tormenta (storm)
-- ---------------------------------------------------------------------
SELECT 
    ts, 
    CASE
        WHEN description LIKE '%rain%' OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions
FROM 
    weather_records;


-- ---------------------------------------------------------------------
-- 6. Viajes del Loop (id 50) a O'Hare (id 63) los sábados,
--    con su duración y las condiciones climáticas al inicio del viaje
--    Resultado usado en la prueba de hipótesis: project_sql_result_07.csv
-- ---------------------------------------------------------------------
SELECT 
    trips.start_ts, 
    CASE
        WHEN weather_records.description LIKE '%rain%' 
          OR weather_records.description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions,
    trips.duration_seconds
FROM 
    trips
INNER JOIN 
    weather_records ON trips.start_ts = weather_records.ts
WHERE
    trips.pickup_location_id = 50
    AND trips.dropoff_location_id = 63
    AND EXTRACT(DOW FROM trips.start_ts) = 6   -- 6 = sábado en PostgreSQL
ORDER BY 
    trips.trip_id;
