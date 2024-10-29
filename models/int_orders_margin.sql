SELECT orders_id,
date_date,
ROUND(SUM (revenue),2) as revenue ,
ROUND(SUM (quantity),2) as quantity,
ROUND((SUM ((quantity * purchase_price))),2) AS purchase_cost,
ROUND((SUM ((revenue - (quantity * purchase_price)))),2) AS margin
FROM {{ ref("stg_raw__sales")}}
INNER JOIN {{ref("stg_raw__product")}} using(products_id)
GROUP BY orders_id, date_date


