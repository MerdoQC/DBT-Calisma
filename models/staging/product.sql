select *
from {{ source('raw', 'raw_product') }}