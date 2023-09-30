## Carga de datos de la dimensión Empleado
## ---------------------------------------

## dim_staff

-- Inserta los datos en la dimension
-- a partir de una consulta
INSERT INTO sakila_datawh.dim_staff (
    staff_first_name,
    staff_last_name,
    staff_id,
    staff_store_id,
    staff_active
)
-- 1. obtiene los datos de los empleados usando
--    la tabla sakila.staff
SELECT
    first_name,
    last_name,
    staff_id,
    store_id,
    active
FROM sakila.staff
;