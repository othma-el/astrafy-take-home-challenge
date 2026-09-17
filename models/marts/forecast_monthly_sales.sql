{{ config(materialized='table') }}

WITH monthly_sales AS (

    SELECT
        EXTRACT(YEAR FROM order_date) AS sales_year,
        EXTRACT(MONTH FROM order_date) AS sales_month,
        SUM(net_sales) AS revenue
    FROM {{ ref('stg_orders') }}
    GROUP BY 1,2

),

growth_rate AS (

    SELECT
        (
            SUM(CASE
                    WHEN sales_year = 2026
                     AND sales_month BETWEEN 7 AND 12
                    THEN revenue
                    ELSE 0
                END)

            /

            SUM(CASE
                    WHEN sales_year = 2025
                     AND sales_month BETWEEN 7 AND 12
                    THEN revenue
                    ELSE 0
                END)

        ) AS growth_factor

    FROM monthly_sales

)

SELECT

    DATE(2027, m26.sales_month, 1) AS forecast_month,

    ROUND(m25.revenue, 2) AS revenue_2025,

    ROUND(m26.revenue, 2) AS revenue_2026,

    ROUND(
        (growth_factor - 1) * 100,
        2
    ) AS growth_rate_pct,

    ROUND(
        m26.revenue * growth_factor,
        2
    ) AS forecast_sales_2027

FROM monthly_sales m26

LEFT JOIN monthly_sales m25
    ON m26.sales_month = m25.sales_month
   AND m25.sales_year = 2025

CROSS JOIN growth_rate

WHERE m26.sales_year = 2026

ORDER BY forecast_month