with source as (
    select * from {{source('northwind', 'us_states')}}
), 

renamed as (
    select
        state_id, state_name, state_abbr, state_region
    from source
)

select * from renamed