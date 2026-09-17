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
    p.qty_product

FROM {{ ref('stg_orders') }} o

LEFT JOIN products_per_order p
    ON o.order_id = p.order_id