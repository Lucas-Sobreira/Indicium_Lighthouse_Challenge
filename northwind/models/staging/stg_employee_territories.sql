with source as (
    select * from {{source('northwind', 'employee_territories')}}
), 

renamed as (
    select
        employee_id, territory_id
    from source
)

select * from renamed