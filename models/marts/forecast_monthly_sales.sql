{{ config(materialized='table') }}

WITH sales_2026 AS (

    SELECT
        EXTRACT(MONTH FROM order_date) AS sales_month,
        SUM(net_sales) AS revenue_2026

    FROM {{ ref('stg_orders') }}

    WHERE EXTRACT(YEAR FROM order_date) = 2026

    GROUP BY 1

),

avg_2026 AS (

    SELECT
        AVG(revenue_2026) AS avg_monthly_revenue
    FROM sales_2026

)

SELECT

    DATE(2027, s.sales_month, 1) AS forecast_month,

    s.revenue_2026,

    ROUND(
        s.revenue_2026
        /
        a.avg_monthly_revenue,
        2
    ) AS seasonality_factor,

    ROUND(
        a.avg_monthly_revenue
        *
        (
            s.revenue_2026
            /
            a.avg_monthly_revenue
        ),
        2
    ) AS forecast_sales_2027

FROM sales_2026 s
CROSS JOIN avg_2026 a

ORDER BY forecast_month