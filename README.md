# Astrafy Take Home Challenge


## Data Quality Assessment

Before developing the dbt models, I validated
the consistency between the orders and sales datasets.

### Checks performed

- Distinct order count comparison
- Distinct customer count comparison
- Revenue reconciliation
- Referential integrity validation

### Findings

An orphan order (5361303) was identified in the
sales dataset but was missing from orders.

Investigation showed that the related product_id
(47321) was valid and used in other orders.

Revenue reconciliation revealed a difference of
47.0833, matching the value of the orphan order.

### Resolution

For the purpose of this exercise, the orphan order
was excluded from the sales view to maintain
consistency between both datasets.

In a production environment, validation would be
performed with the data owner before applying such
a correction.



## -----------------------------------------



## Architecture

Raw Tables
→ dbt Staging
→ dbt Marts
→ LookML Semantic Layer
→ Looker Studio Dashboard

## Data Quality

An orphan order (5361303) was found in sales
but not in orders.

The discrepancy was investigated and excluded
from the analytical layer for the purpose of the exercise.

## dbt Models

- stg_orders
- stg_sales
- ex1_orders_2026
- ex2_orders_per_month
- ex3_avg_products_per_order
- ex4_orders_qty_product
- ex5_order_segmentation
- ex6_orders_2026_segmented

## Data Quality Tests

The following dbt tests were implemented:

### stg_orders

- not_null(order_id)
- unique(order_id)
- not_null(customer_id)
- not_null(order_date)

### stg_sales

- not_null(order_id)
- not_null(customer_id)
- not_null(product_id)
- relationships(order_id → stg_orders.order_id)

### Results

All tests passed successfully.

PASS = 8
WARN = 0
ERROR = 0

The relationship test validates referential integrity between
sales and orders and confirms that each sale is associated
with a valid order.

## LookML Semantic Layer

Files:

- astrafy.model.lkml
- orders_2026.view.lkml

Measures:
- Number of Orders
- Number of Customers
- Net Sales
- Average Order Value
- Average Products per Order

Dimensions:
- Order Date
- Customer ID
- Order ID
- Customer Segment

## Dashboard

<PASTE LOOKER STUDIO LINK HERE>
