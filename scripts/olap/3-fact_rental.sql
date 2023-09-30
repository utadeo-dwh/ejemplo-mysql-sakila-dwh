## Carga de datos de la tabla de Hechos
## ------------------------------------

## fact_rental

-- Inserta los datos en la tabla de hechos
-- a partir de una consulta
INSERT INTO fact_rental (
    customer_key,
    staff_key,
    film_key,
    store_key,
    date_key,
    count_returns,
    count_rentals
)
-- 1. obtiene los datos uniendo la tabla sakila.rental
--    con las tablas de dimension en sakila_datawh
WITH datos AS (
    SELECT 
        dim_customer.customer_key,
        dim_staff.staff_key,
        dim_film.film_key,
        dim_store.store_key,
        TO_DAYS(rental_date) AS date_key,
        CASE WHEN return_date IS NULL THEN 0 ELSE 1 END AS count_returns,
        1 as count_rentals
    FROM sakila.rental AS rental
        LEFT JOIN sakila_datawh.dim_customer AS dim_customer
            ON rental.customer_id = dim_customer.customer_id
        LEFT JOIN sakila_datawh.dim_staff as dim_staff
            ON rental.staff_id = dim_staff.staff_id
        LEFT JOIN sakila.inventory AS inventory
            ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN sakila_datawh.dim_film as dim_film
            ON inventory.film_id = dim_film.film_id
        LEFT JOIN sakila_datawh.dim_store as dim_store
            ON inventory.store_id = dim_store.store_id
)
-- 2. luego agrupa los datos para evitar situaciones donde
--    se resulten dos o más filas para la misma transacción
SELECT 
    customer_key,
    staff_key,
    film_key,
    store_key,
    date_key,
    SUM(count_returns),
    SUM(count_rentals)
FROM datos
GROUP BY 
    customer_key,
    staff_key,
    film_key,
    store_key,
    date_key
;