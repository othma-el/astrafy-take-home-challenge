WITH order_history AS (

    SELECT
        current_order.customer_id,
        current_order.order_id,
        current_order.order_date,

        COUNT(previous_order.order_id) AS previous_orders_12m

    FROM {{ ref('stg_orders') }} current_order

    LEFT JOIN {{ ref('stg_orders') }} previous_order
        ON current_order.customer_id = previous_order.customer_id
        AND previous_order.order_date < current_order.order_date
        AND previous_order.order_date >= DATE_SUB(current_order.order_date, INTERVAL 12 MONTH)

    GROUP BY
        current_order.customer_id,
        current_order.order_id,
        current_order.order_date

)

SELECT
    customer_id,
    order_id,
    order_date,

    CASE
        WHEN previous_orders_12m = 0 THEN 'New'
        WHEN previous_orders_12m BETWEEN 1 AND 3 THEN 'Returning'
        ELSE 'VIP'
    END AS order_segmentation

FROM order_history

WHERE EXTRACT(YEAR FROM order_date) = 2026