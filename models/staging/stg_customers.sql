select
    id              as customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    created_at
from {{ source('raw', 'customers') }}
