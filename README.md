# Astrafy Take Home Challenge

## Overview

This project was developed as part of the Astrafy Analytics Engineering Take Home Challenge.

The solution covers:

- Data quality assessment and validation
- dbt data transformation pipeline
- Customer segmentation logic
- LookML semantic layer
- Business dashboard
- Revenue forecasting bonus exercise

---

# Architecture

```text
Raw Data
    ↓
Standardised Views
    ↓
dbt Staging Models
    ↓
dbt Mart Models
    ↓
LookML Semantic Layer
    ↓
Looker Studio Dashboard
```

---

# Data Quality Assessment

Before building the transformation pipeline, both datasets were validated to ensure consistency.

## Validation Performed

### Order Validation

Compared distinct `order_id` values between:

- raw.v_orders
- raw.v_sales

An orphan order was identified:

```text
order_id = 5361303
```

The order existed in the sales dataset but was missing from the orders dataset.

The issue was investigated and documented.

### Customer Validation

Compared distinct customer counts between both datasets.

Result:

```text
1,716 distinct customers
```

were found in both datasets.

### Revenue Validation

Compared total revenue between:

- v_orders
- v_sales

The revenue discrepancy matched the orphan order identified during the order validation process.

### Remediation

For the purpose of the challenge, the orphan order was excluded from the sales view to maintain referential integrity between orders and sales.

In a production environment, this modification should first be validated with the business owner or source system owner.

---

# dbt Models

## Staging

### stg_orders

Standardises column names and prepares order-level data.

### stg_sales

Standardises sales-line data and product information.

## Marts

### ex1_orders_2026

Number of distinct orders in 2026.

### ex2_orders_per_month

Monthly order volume for 2026.

### ex3_avg_products_per_order

Average quantity of products per order by month.

### ex4_orders_qty_product

Order-level table enriched with product quantities.

### ex5_order_segmentation

Customer segmentation model.

Business rules:

| Segment | Definition |
|----------|----------|
| New | 0 orders in previous 12 months |
| Returning | 1 to 3 orders in previous 12 months |
| VIP | 4+ orders in previous 12 months |

### ex6_orders_2026_segmented

Final analytical dataset used for reporting and dashboarding.

Contains:

- order_date
- customer_id
- order_id
- net_sales
- qty_product
- order_segmentation

---

# Data Quality Tests

Implemented using dbt generic tests.

## stg_orders

- not_null(order_id)
- unique(order_id)
- not_null(customer_id)
- not_null(order_date)

## stg_sales

- not_null(order_id)
- not_null(customer_id)
- not_null(product_id)
- relationships(order_id → stg_orders.order_id)

## Results

```text
PASS = 8
WARN = 0
ERROR = 0
```

The relationship test validates referential integrity between sales and orders.

---

## LookML Semantic Layer

The semantic layer was designed to be deployment-ready and follows LookML best practices.

### Files

```text
lookml/
├── astrafy.model.lkml
├── orders_2026.view.lkml
└── forecast_monthly_sales.view.lkml
```

### Explore: Orders & Customer Segmentation

#### Dimensions

- Order ID
- Customer ID
- Order Date
- Customer Segment
- Product Quantity
- Net Sales

#### Measures

- Total Revenue
- Total Orders
- Total Customers
- Record Count
- Average Order Value
- Average Products per Order

#### Business Use Cases

- Revenue analysis
- Customer behaviour analysis
- Order performance tracking
- Customer segmentation analysis
- Sales trend analysis

### Explore: Revenue Forecast

#### Dimensions

- Forecast Month
- Revenue 2025
- Revenue 2026
- Growth Rate %
- Forecast Sales 2027

#### Measures

- 2025 Half Year Revenue
- 2026 Total Revenue
- 2027 Total Revenue
- Forecast Growth Contribution
- Record Count

#### Business Use Cases

- Revenue forecasting
- Growth monitoring
- Budget planning
- Marketing planning
- Future performance analysis

The semantic layer enables business users to analyse customer behaviour, revenue performance, customer segmentation, and future revenue projections in a reusable, governed, and AI-ready manner.

---

# Dashboard

The dashboard focuses on:

## Executive KPIs

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Average Products per Order

## Revenue Analysis

- Revenue by Month
- Revenue by Customer Segment

## Customer Analysis

- Orders by Segment
- Customers by Segment
- Revenue by Segment

## Filters

- Month
- Customer Segment

---

# Bonus – Revenue Forecast

A monthly revenue forecast for 2027 was created using the historical revenue profile and seasonality factors.

The objective was to provide an indicative business forecast while maintaining explainability and business relevance.

## Assumptions

The forecast assumes that the seasonal revenue patterns observed in the historical data continue into 2027.

Seasonality factors were calculated at the monthly level and applied to generate monthly revenue estimates.

## Data Limitation

Historical data for 2025 is incomplete.

The dataset contains records from July 2025 onwards, while data for January 2025 through June 2025 is unavailable.

Because a complete 2025 revenue history was not available:

- A reliable year-over-year trend analysis could not be performed.
- Trend estimation based on 2025 and 2026 would have introduced bias.
- The forecast therefore relies primarily on the complete 2026 revenue profile and seasonality patterns.

## Forecast Interpretation

The forecast should be considered an indicative business forecast and proof of concept rather than a production-grade predictive model.

A production solution would benefit from:

- More historical data
- Complete yearly observations
- External business drivers
- Statistical forecasting methods (ARIMA, Prophet, Machine Learning)

---

# Technology Stack

- BigQuery
- dbt Core
- LookML
- Looker Studio
- Git / GitHub

---

# Author

Othman El Mahi

# Dashboard Link:

```text
https://datastudio.google.com/u/0/reporting/ff0d6bee-eebc-4e11-91f7-142b51651c0c/page/5wk8F
```
