## Carga de datos de la dimensión Película
## ---------------------------------------

## dim_film

-- Inserta los datos en la dimension
-- a partir de una consulta
INSERT INTO sakila_datawh.dim_film (
    film_title,
    film_description,
    film_release_year,
    film_language,
    film_rental_duration,
    film_rental_rate,
    film_duration,
    film_replacement_cost,
    film_rating_text,
    film_id
)
-- 1. obtiene los datos de la tabla sakila.film 
--    y las tablas relacionadas: language 
SELECT 
    title, 
    description, 
    cast(release_year AS char(4)) release_year,
    l.name AS language,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    rating,
    film_id
FROM sakila.film f
    LEFT JOIN sakila.language l USING(language_id)
;