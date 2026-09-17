view: forecast_monthly_sales {

  sql_table_name: `astrafy-test-507518.analytics.forecast_monthly_sales` ;;

  label: "Forecast Monthly Sales"

  description:
    "Forecasted monthly sales for 2027 based on the observed Jul-Dec 2025 to Jul-Dec 2026 growth rate applied to the 2026 seasonal pattern."

  # ===========================
  # Dimensions
  # ===========================

  dimension_group: forecast_month {
    label: "Forecast Month"
    description: "Forecasted month in 2027."
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.forecast_month ;;
  }

  dimension: growth_rate_pct {
    label: "Growth Rate %"
    description:
      "Observed growth rate between Jul-Dec 2025 and Jul-Dec 2026."
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.growth_rate_pct / 100 ;;
  }

  dimension: revenue_2025 {
    label: "Revenue 2025"
    description:
      "Actual monthly revenue recorded in 2025."
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.revenue_2025 ;;
  }

  dimension: revenue_2026 {
    label: "Revenue 2026"
    description:
      "Actual monthly revenue recorded in 2026."
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.revenue_2026 ;;
  }

  dimension: forecast_sales_2027 {
    label: "Forecast Sales 2027"
    description:
      "Forecasted sales value for 2027."
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.forecast_sales_2027 ;;
  }

  # ===========================
  # Measures
  # ===========================

  measure: revenue_2025_half_year {
    label: "2025 Half Year Revenue"
    description:
      "Total revenue from July to December 2025."
    type: sum
    sql: ${revenue_2025} ;;
    value_format_name: decimal_2
  }

  measure: total_revenue_2026 {
    label: "2026 Total Revenue"
    description:
      "Total revenue generated in 2026."
    type: sum
    sql: ${revenue_2026} ;;
    value_format_name: decimal_2
  }

  measure: total_revenue_2027 {
    label: "2027 Total Revenue"
    description:
      "Projected total revenue for 2027."
    type: sum
    sql: ${forecast_sales_2027} ;;
    value_format_name: decimal_2
  }

  measure: forecast_growth_contribution {
    label: "Forecast Growth Contribution"
    description:
      "Additional revenue generated in the forecast compared to 2026."
    type: number
    sql: ${total_revenue_2027} - ${total_revenue_2026} ;;
    value_format_name: decimal_2
  }

  measure: record_count {
    label: "Record Count"
    description:
      "Number of forecast records."
    type: count
  }

}