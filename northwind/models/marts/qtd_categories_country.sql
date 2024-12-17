{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
), 
order_details as (
    select * from {{ ref('stg_order_details') }}
), 
products as (
    select * from {{ ref('stg_products') }}
), 
suppliers as (
    select * from {{ ref('stg_suppliers') }}
), 
categories as (
    select * from {{ ref('stg_categories') }}
),
employees as (
    select * from {{ ref('stg_employees') }}
), 
employee_territories as (
    select * from {{ ref('stg_employee_territories') }}
), 
territories as (
    select * from {{ ref('stg_territories') }}
),  
region as (
    select * from {{ ref('stg_region') }}
), 
shippers as (
    select * from {{ ref('stg_shippers') }}
), 
customers as (
    select * from {{ ref('stg_customers') }}
), 

joined as (
    select  o.order_id, 
            o.order_date, 
            o.required_date, 
            o.shipped_date, 
            o.days_delivery, 
            sh.company_name, 
            o.ship_name, 
            o.freight, 
            o.ship_address, 
            o.ship_city, 
            sh.phone, 
            o.ship_postal_code, 
            o.ship_country, 
	        pd.product_name, 
            od.unit_price, 
            od.quantity, 
            od.discount, 
	        sup.company_name as supplier, 
            sup.contact_name as supplier_contact_name, 
            sup.address as supplier_address, 
            sup.city as supplier_city, 
            sup.region as supplier_region, 
            sup.postal_code as supplier_postal_code, 
            sup.country as supplier_country, 
            sup.phone as supplier_phone, 
            sup.homepage as supplier_homepage, 
	        cat.category_name, 
            cat.description as category_description, 
            cat.picture as category_picture, 
	        pd.quantity_per_unit, 
            pd.unit_price, 
            pd.units_in_stock, 
            pd.units_on_order, 
            (pd.units_on_order - pd.units_in_stock) as units_excess, 
            pd.discontinued, 
	        emp.last_name as employee_last_name, 
            emp.first_name as employee_first_name, 
            emp.title as employee_title, 
            emp.title_of_courtesy as employee_title_of_courtesy, 
            emp.birth_date as employee_birth_date, 
            emp.hire_date as employee_hire_date, 
            emp.hire_age as employee_hire_age, 
            emp.city as employee_city, 
            emp.country as employee_country, 
            emp.notes as employee_notes, 
	        te.territory_description, 
	        re.region_description, 
	        c.company_name as customer_company_name, 
            c.contact_name as customer_contact_name, 
            c.contact_title as customer_contact_title, 
            c.address as customer_address, 
            c.city as customer_city, 
            c.region as customer_region, 
            c.postal_code as customer_postal_code, 
            c.country as customer_country, 
            c.phone as customer_phone 
    from orders as o
    left join order_details as od on o.order_id = od.order_id
    left join products as pd on od.product_id = pd.product_id
    left join suppliers as sup on pd.supplier_id = sup.supplier_id
    left join categories as cat on pd.category_id = cat.category_id
    left join employees as emp on o.employee_id = emp.employee_id
    left join employee_territories as empte on emp.employee_id = empte.employee_id
    left join territories as te on empte.territory_id = te.territory_id
    left join region as re on te.region_id = re.region_id
    left join shippers as sh on o.ship_via = sh.shipper_id
    left join customers as c on o.customer_id = c.customer_id 
), 

relatorio as (
    SELECT 
        SUM(units_on_order) AS quantity_per_category_country, 
        category_name, 
        customer_country, 
        customer_region
    FROM 
        joined
    WHERE 
        units_excess < 0 
        AND discontinued = 0 
        AND units_on_order > 0
    GROUP BY 
        category_name, 
        customer_country, 
        customer_region
    ORDER BY 
        category_name, quantity_per_category_country DESC
)

select * from relatorio