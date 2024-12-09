with source as (
    select * from {{source('northwind', 'customers')}}
), 

renamed as (
    select
        customer_id, company_name, contact_name, lower(contact_title) as contact_title, lower(address) as address, 
        lower(city) as city, region, postal_code, lower(country) as country, phone, fax
    from source
)

select * from renamed