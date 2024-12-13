with source as (
    select * from {{source('northwind', 'employees')}}
), 

renamed as (
    select
        employee_id, last_name, first_name, lower(title) as title, lower(title_of_courtesy) as title_of_courtesy,
        birth_date, hire_date, round((extract(year from age(hire_date, birth_date)) * 12 + extract(month from age(hire_date, birth_date)))/12, 2) AS hire_age, 
        lower(city) as city, lower(country) as country, notes
    from source
)

select * from renamed