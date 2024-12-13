with source as (
    select * from {{source('northwind', 'region')}}
), 

renamed as (
    select
        region_id, region_description
    from source
)

select * from renamed