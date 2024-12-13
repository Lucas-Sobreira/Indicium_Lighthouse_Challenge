with source as (
    select * from {{source('northwind', 'suppliers')}}
), 

renamed as (
    select
        supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, homepage
    from source
)

select * from renamed