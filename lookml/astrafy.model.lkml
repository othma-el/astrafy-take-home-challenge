connection: "bigquery_connection"

include: "*.view.lkml"

explore: orders_2026 {

  label: "2026 Orders and Customer Segmentation"

  description:
    "Business exploration of orders, revenue,
     customer behaviour and customer segmentation.
     Supports analysis of New, Returning and VIP customers."

}

explore: forecast_monthly_sales {

  label: "2027 Revenue Forecast"

  description:
    "Forecasted revenue for 2027 based on the
     observed Jul-Dec 2025 to Jul-Dec 2026
     growth trend applied to 2026 monthly seasonality."

}