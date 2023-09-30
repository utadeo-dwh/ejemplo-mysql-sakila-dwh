## Script para crear la bodega de datos 
## ------------------------------------

-- 1. Elimina la base de datos si ya existe
DROP DATABASE IF EXISTS sakila_datawh;

-- 2. Crea la base de datos sakila_datawh
source /scripts/olap/1-sakila_datawh.sql

-- 3. Ejecuta los procesos de carga de las dimensiones
source /scripts/olap/2-dim_customer.sql
source /scripts/olap/2-dim_date.sql
source /scripts/olap/2-dim_film.sql
source /scripts/olap/2-dim_staff.sql
source /scripts/olap/2-dim_store.sql

-- 4. Ejecuta los procesos de carga de los hechos
source /scripts/olap/3-fact_rental.sql