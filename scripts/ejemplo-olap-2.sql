use sakila_datawh;

-- 1. obtiene la sábana de datos de la bodega
with datos as (
    select 
        fact.count_rentals,
        fact.count_returns,
        dim_customer.*,
        dim_date.*,
        dim_film.*,
        dim_staff.*,
        dim_store.* 
    from fact_rental as fact
        left join dim_customer using (customer_key)
        left join dim_date  using (date_key)
        left join dim_film  using (film_key)
        left join dim_staff using (staff_key)
        left join dim_store using (store_key)
),
-- 2. agrupa los datos y los suma, cuenta, promedia, ...
datos_agrupados as (
    select 
        store_city ciudad,
        customer_name cliente,
        year_month_number mes,
        sum(count_rentals) cantidad
    from datos
    group by 
        ciudad,
        cliente,
        mes
),
-- 3. hace una transposición y coloca los meses en columnas
datos_meses_en_columnas as (
    select 
        ciudad,
        cliente,
        sum(case when mes='2005-05' then cantidad else 0 end) as mayo2005,
        sum(case when mes='2005-06' then cantidad else 0 end) as junio2005
    from datos_agrupados
    group by
        ciudad, 
        cliente
),
-- 4. realiza operaciones sobre los dato en columnas
datos_meses_comparativo as (
    select 
        ciudad,
        cliente,
        mayo2005,
        junio2005,
        (junio2005 - mayo2005) as diferencia,
        ((junio2005 - mayo2005)/mayo2005) as porc_crecim
    from datos_meses_en_columnas
)
-- 5. muestra la información en el orden apropiado
select *
from datos_meses_comparativo
order by ciudad, cliente
limit 5
;