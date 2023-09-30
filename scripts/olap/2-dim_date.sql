## Carga de datos de la dimensión Tiempo
## -------------------------------------

## dim_date

-- Inserta los datos en la dimension
-- a partir de una consulta
INSERT INTO sakila_datawh.dim_date (
    date_key,
    date_value,
    date_medium,
    month_number,
    month_name,
    year4,
    year_month_number
)
-- 1. obtiene los datos de las fechas de la tabla 
--    de sakila.rental
WITH fechas AS (
    SELECT DISTINCT DATE(rental_date) AS fecha
    FROM sakila.rental 
)
-- 2. obtiene los campos adicionales de la dimensión
--    usando funciones sobre el campo de fecha
SELECT
    TO_DAYS(fecha)  AS date_key,
    fecha  AS date_value,
    DATE_FORMAT(fecha, '%d %M %Y')  AS date_medium,
    MONTH(fecha)  AS month,
    MONTHNAME(fecha)  AS month_name,
    YEAR(fecha) AS year4,
    DATE_FORMAT(fecha, '%Y-%m')  AS year_month_number
FROM fechas
;
