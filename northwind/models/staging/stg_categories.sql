with source as (
    select * from {{source('northwind', 'categories')}}
), 

renamed as (
    select
        category_id, lower(category_name) as category_name, lower(description) as description, picture
    from source
)

select * from renamed