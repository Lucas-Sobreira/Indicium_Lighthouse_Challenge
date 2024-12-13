with source as (
    select * from {{source('northwind', 'orders')}}
), 

renamed as (
    select
        order_id, customer_id, employee_id, order_date, required_date, shipped_date,
        (extract(day from age(shipped_date, order_date))) AS days_delivery, ship_via, freight, lower(ship_name) as ship_name,
        lower(ship_address) as ship_address, lower(ship_city) as ship_city, lower(ship_region) as ship_region, ship_postal_code, 
        lower(ship_country) as ship_country
    from source
)

select * from renamed