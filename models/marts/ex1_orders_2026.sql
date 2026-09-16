SELECT
    COUNT(DISTINCT order_id) AS nb_orders_2026
FROM {{ ref('stg_orders') }}
WHERE EXTRACT(YEAR FROM order_date) = 2026