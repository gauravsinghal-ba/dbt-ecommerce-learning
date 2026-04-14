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
    ot.item_count,
    case
    when ot.order_total > 3000 then 'high'
    when ot.order_total > 1000 then 'medium'
    else 'low'
end as revenue_category
from orders o
left join order_totals ot using (order_id)
