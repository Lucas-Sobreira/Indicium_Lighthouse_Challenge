with source as (
    select * from {{source('northwind', 'shippers')}}
), 

renamed as (
    select
        shipper_id, company_name, phone
    from source
)

select * from renamed