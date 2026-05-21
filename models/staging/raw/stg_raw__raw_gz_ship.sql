with 

source as (

    select * from {{ source('raw', 'raw_gz_ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
         SAFE_CAST(logcost AS FLOAT64) as logcost,
        ship_cost

    from source

)

select * from renamed