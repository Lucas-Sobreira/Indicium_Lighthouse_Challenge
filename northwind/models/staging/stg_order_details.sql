with source as (
    select * from {{source('northwind', 'order_details')}}
), 

renamed as (
    select 
        order_id, product_id, ROUND(cast(unit_price as numeric), 2) as unit_price, quantity, ROUND(cast(discount as numeric), 2) as discount
    from source
    where 
        discount >= 0 and discount <= 1 -- garante que o valor de desconto esteja entre 0% e 100% 
)

select * from renamed