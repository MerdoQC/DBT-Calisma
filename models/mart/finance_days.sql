with finance as (

    select *
    from {{ ref('join_intemediate') }}

),

daily_finance as (

    select

        date_date,

        count(distinct orders_id) as total_transactions,

        round(sum(revenue), 2) as total_revenue,

        round(
            sum(revenue)
            / count(distinct orders_id),
            2
        ) as average_basket,

        round(
            sum(operational_margin),
            2
        ) as operational_margin,

        round(
            sum(purchase_cost),
            2
        ) as total_purchase_cost,

        round(
            sum(shipping_fee),
            2
        ) as total_shipping_fees,

        round(
            sum(logcost),
            2
        ) as total_logistic_costs,

        sum(quantity) as total_quantity_sold

    from finance

    group by date_date

)

select * from daily_finance