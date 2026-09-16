# Astrafy Take Home Challenge

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

Implemented tests:

- unique(order_id)
- not_null(order_id)
- not_null(customer_id)
- not_null(product_id)

All tests passed.

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
