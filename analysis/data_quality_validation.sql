-- =====================================================
-- Data Quality Assessment
-- Astrafy Take Home Challenge
-- =====================================================

-- Objective:
-- Validate consistency between orders and sales datasets before building the dbt transformation pipeline.


-- Create standardised views

CREATE OR REPLACE VIEW `astrafy-test-507518.raw.v_orders` AS
SELECT
    date_date AS order_date,
    customers_id AS customer_id,
    orders_id AS order_id,
    net_sales
FROM `astrafy-test-507518.raw.orders`;

CREATE OR REPLACE VIEW `astrafy-test-507518.raw.v_sales` AS
SELECT
    date_date AS order_date,
    customer_id,
    order_id,
    products_id AS product_id,
    net_sales,
    qty
FROM `astrafy-test-507518.raw.sales`;

-- Distinct order validation

SELECT
    COUNT(DISTINCT order_id)
FROM `astrafy-test-507518.raw.v_orders`;

SELECT
    COUNT(DISTINCT order_id)
FROM `astrafy-test-507518.raw.v_sales`;

-- Distinct customer validation

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer
FROM `astrafy-test-507518.raw.v_orders`;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer
FROM `astrafy-test-507518.raw.v_sales`;

-- Find orphan orders

SELECT DISTINCT order_id
FROM `astrafy-test-507518.raw.v_sales`
EXCEPT DISTINCT
SELECT DISTINCT order_id
FROM `astrafy-test-507518.raw.v_orders`;
-- Result:
-- order_id = 5361303 exists in sales but not in orders

-- Investigate orphan order

SELECT *
FROM `astrafy-test-507518.raw.v_sales`
WHERE order_id = 5361303;

SELECT *
FROM `astrafy-test-507518.raw.v_sales`
WHERE product_id = 47321;

-- Revenue reconciliation

SELECT
    'v_orders' AS table_name,
    SUM(net_sales) AS total_net_sales
FROM `astrafy-test-507518.raw.v_orders`

UNION ALL

SELECT
    'v_sales' AS table_name,
    SUM(net_sales) AS total_net_sales
FROM `astrafy-test-507518.raw.v_sales`;

-- Update v_sales view
-- For the purpose of the challenge, the orphan order is excluded to maintain referential integrity between orders and sales.
-- In a production environment, this change would first be validated with the data owner before implementation.
CREATE OR REPLACE VIEW `astrafy-test-507518.raw.v_sales` AS
SELECT
    date_date AS order_date,
    customer_id,
    order_id,
    products_id AS product_id,
    net_sales,
    qty
FROM `astrafy-test-507518.raw.sales`
WHERE order_id <> 5361303;