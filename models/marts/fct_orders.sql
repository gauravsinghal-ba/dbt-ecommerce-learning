with orders as (
    select * from {{ ref('stg_orders') }}
),
order_items as (
    select * from {{ ref('stg_order_items') }}
),
order_totals as (
    select
        order_id,
        sum(total_price)        as order_total,
        count(order_item_id)    as item_count
    from order_items
    group by order_id
)
select
    o.order_id,
    o.customer_id,
    o.status,
    o.ordered_at,
    ot.order_total,
    ot.item_count
from orders o
left join order_totals ot using (order_id)
