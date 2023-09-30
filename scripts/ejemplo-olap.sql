use sakila_datawh;

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
        left join dim_date using (date_key)
        left join dim_film using (film_key)
        left join dim_staff using (staff_key)
        left join dim_store using (store_key)
)
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
limit 5
;