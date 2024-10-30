select
    ship.orders_id,
    sales.date_date,
    ship.shipping_fee,
    ship.logcost,
    cast(ship.ship_cost as float64) as ship_cost,
    round(sum(sales.revenue), 2) as revenue,
    round(sum(sales.quantity), 2) as quantity,
    round(sum(sales.quantity * (sales.revenue / sales.quantity)), 2) as purchase_cost,  -- Modify if actual purchase_price is available
    round(
        sum(sales.revenue - (sales.quantity * (sales.revenue / sales.quantity))), 2
    ) as margin,
    round(
        sum(
            (sales.revenue - (sales.quantity * (sales.revenue / sales.quantity)))
            + ship.shipping_fee
            - ship.logcost
            - ship.ship_cost
        ),
        2
    ) as operational_margin
from {{ ref("stg_raw__sales") }} as sales
inner join {{ ref("stg_raw__ship") }} as ship on sales.orders_id = ship.orders_id  -- Ensure this join condition is correct
group by
    ship.orders_id, sales.date_date, ship.shipping_fee, ship.logcost, ship.ship_cost
