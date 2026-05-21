with sales as (

    select *
    from {{ ref('stg_raw__raw_gz_sales') }}

),

product as (

    select *
    from {{ ref('stg_raw__raw_product') }}

),

ship as (

    select *
    from {{ ref('stg_raw__raw_gz_ship') }}

),

joined as (

    select
        sales.date_date,
        sales.orders_id,
        sales.products_id,
        sales.quantity,
        sales.revenue,
        product.purchase_price,
        ship.shipping_fee,
        ship.logcost,
  SAFE_CAST(ship_cost AS FLOAT64) as ship_cost

    from sales

    left join product
        on sales.products_id = product.products_id

    left join ship
        on sales.orders_id = ship.orders_id

),

calculated as (

    select
        *,

        ROUND(quantity * purchase_price, 2) as purchase_cost,

        ROUND(
            revenue - (quantity * purchase_price),
            2
        ) as margin,

        ROUND(
            revenue + shipping_fee - logcost - ship_cost,
            2
        ) as operational_margin

    from joined

)

select * from calculated