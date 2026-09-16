connection: "bigquery_connection"

include: "*.view.lkml"

explore: orders_2026 {

  label: "2026 Orders and Customer Segmentation"

  description:
    "Explore for analysing orders, revenue,
     customer behaviour and customer segmentation."

}