{{ config(materialized='table') }}

WITH products_per_order AS (

    SELECT
        order_id,
        SUM(qty) AS qty_product
    FROM {{ ref('stg_sales') }}
    GROUP BY 1

)

SELECT
    o.order_date,
    o.customer_id,
    o.order_id,
    o.net_sales,
    p.qty_product,
    s.order_segmentation

FROM {{ ref('stg_orders') }} o

LEFT JOIN products_per_order p
    ON o.order_id = p.order_id

LEFT JOIN {{ ref('ex5_order_segmentation') }} s
    ON o.order_id = s.order_id

WHERE EXTRACT(YEAR FROM o.order_date) = 2026