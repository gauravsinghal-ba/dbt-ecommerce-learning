with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
customer_orders as (
    select
        customer_id,
        count(order_id)         as total_orders,
        min(ordered_at)         as first_order_at,
        max(ordered_at)         as latest_order_at
    from orders
    group by customer_id
)
select
    c.*,
    coalesce(co.total_orders, 0)    as total_orders,
    co.first_order_at,
    co.latest_order_at
from customers c
left join customer_orders co using (customer_id)
