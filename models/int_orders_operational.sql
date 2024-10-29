SELECT 
    ship.orders_id,
    sales.date_date,
    ship.shipping_fee,
    ship.logcost,
    CAST(ship.ship_cost AS FLOAT64) AS ship_cost,
    ROUND(SUM(sales.revenue), 2) AS revenue,
    ROUND(SUM(sales.quantity), 2) AS quantity,
    ROUND(SUM(sales.quantity * (sales.revenue / sales.quantity)), 2) AS purchase_cost, -- Modify if actual purchase_price is available
    ROUND(SUM(sales.revenue - (sales.quantity * (sales.revenue / sales.quantity))), 2) AS margin,
    ROUND(SUM((sales.revenue - (sales.quantity * (sales.revenue / sales.quantity))) + ship.shipping_fee - ship.logcost - ship.ship_cost), 2) AS operational_margin
FROM {{ ref("stg_raw__sales") }} AS sales
INNER JOIN {{ ref("stg_raw__ship") }} AS ship
    ON sales.orders_id = ship.orders_id -- Ensure this join condition is correct
GROUP BY ship.orders_id, sales.date_date, ship.shipping_fee, ship.logcost, ship.ship_cost

