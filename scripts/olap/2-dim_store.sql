## Carga de datos de la dimensión Tienda
## -------------------------------------

## dim_store

-- Inserta los datos en la dimension
-- a partir de una consulta
INSERT INTO sakila_datawh.dim_store (
    store_id,
    store_address,
    store_district,
    store_city,
    store_country,
    store_manager_staff_id,
    store_manager_first_name,
    store_manager_last_name
)
-- 1. obtiene los datos de la tabla sakila.store
--    y las tablas relacionadas: staff (gerente),
--    address, city y country
SELECT 
    s.store_id,
    a.address,
    a.district,
    city.city,
    country.country,
    manager_staff_id,
    e.first_name,
    e.last_name
FROM sakila.store s
    LEFT JOIN sakila.staff e ON s.manager_staff_id=e.staff_id
    LEFT JOIN sakila.address a ON s.address_id=a.address_id
    LEFT JOIN sakila.city city USING (city_id)
    LEFT JOIN sakila.country country USING (country_id)
;