with source as (
    select * from {{source('northwind', 'products')}}
), 

renamed as (
    select
        product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, 
        units_in_stock, units_on_order, reorder_level, discontinued
    from source
)

select * from renamed