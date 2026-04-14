select
    id          as product_id,
    name        as product_name,
    category,
    price,
    created_at
from {{ source('raw', 'products') }}
