with source as (
    select * from {{source('northwind', 'territories')}}
), 

renamed as (
    select
        territory_id, territory_description, region_id
    from source
)

select * from renamed