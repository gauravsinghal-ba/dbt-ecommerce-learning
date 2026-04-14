select
    id          as order_id,
    customer_id,
    status,
    created_at  as ordered_at
from {{ source('raw', 'orders') }}
