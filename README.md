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


## Architecture

Raw Tables
→ dbt Staging
→ dbt Marts
→ LookML Semantic Layer
→ Looker Studio Dashboard

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

The LookML semantic layer defines reusable business measures and dimensions.
Because a Looker environment was not provided as part of the challenge, the equivalent metrics were recreated in Looker Studio to support dashboard visualisation.

## Bonus – Revenue Forecasting

## Forecasting Approach

A monthly revenue forecast for 2027 was created using the historical monthly revenue profile from 2026 combined with seasonality factors.

The objective was to generate an indicative forecast that preserves the monthly sales pattern while avoiding excessive growth assumptions.

The forecast was materialised in:

`forecast_monthly_sales`

and contains:

- Forecast month
- Revenue observed in 2026
- Seasonality factor
- Forecasted revenue

## Assumptions

The forecast is based on the assumption that the seasonal sales pattern observed in 2026 will continue into 2027.

Seasonality factors were applied at the monthly level to capture recurring fluctuations in revenue throughout the year.

## Data Limitations

Historical data for 2025 is incomplete.

The dataset only contains data from July 2025 onwards, while January 2025 to June 2025 is missing.

Because a complete 2025 revenue history was not available:

- A reliable year-over-year analysis could not be performed.
- Monthly trend calculations between 2025 and 2026 would have been biased.
- The forecast was therefore based primarily on the complete 2026 revenue pattern and seasonality profile.

## Forecast Interpretation

This forecast should be considered an indicative business forecast rather than a production-grade predictive model.

A production forecasting solution would benefit from:

- Additional years of historical data
- Complete monthly observations
- External business drivers (campaigns, promotions, seasonality events)
- Statistical forecasting techniques such as ARIMA, Prophet, or machine learning approaches

Despite these limitations, the model provides a reasonable estimate of future revenue while maintaining interpretability and business relevance.

## Dashboard

<PASTE LOOKER STUDIO LINK HERE>



