WITH products_per_order AS (

    SELECT
        order_id,
        order_date,
        SUM(qty) AS qty_product

    FROM {{ ref('stg_sales') }}

    WHERE EXTRACT(YEAR FROM order_date) = 2026

    GROUP BY 1,2

)

SELECT
    DATE_TRUNC(order_date, MONTH) AS order_month,
    AVG(qty_product) AS avg_products_per_order

FROM products_per_order

GROUP BY 1
ORDER BY 1