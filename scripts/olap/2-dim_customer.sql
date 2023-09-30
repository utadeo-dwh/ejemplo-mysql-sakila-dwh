## Carga de datos de la dimensión Clientes
## ---------------------------------------

## dim_customer

-- Inserta los datos en la dimension
-- a partir de una consulta
INSERT INTO sakila_datawh.dim_customer (
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_name,
    customer_active,
    customer_address,
    customer_district,
    customer_city,
    customer_country,
    customer_valid_from,
    customer_valid_through
)
-- 1. obtiene los datos de los clientes usando
--    la tabla sakila.customer y las otras tablas 
--    relacionadas: address, city y country
SELECT 
    customer_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) as name,
    active,
    a.address,
    a.district,
    city.city,
    country.country,
    CURRENT_DATE,
    CURRENT_DATE 
FROM sakila.customer c
    LEFT OUTER JOIN sakila.address a USING (address_id)
    LEFT OUTER JOIN sakila.city city USING (city_id)
    LEFT OUTER JOIN sakila.country country USING (country_id)
;