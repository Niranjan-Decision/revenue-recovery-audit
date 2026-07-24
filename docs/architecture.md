# System Architecture
The pipeline ingests raw BigQuery GA4 obfuscated event logs, flattens array structures via transformation layers into a Silver Data Mart (`fact_sales_transactions`, `fact_funnel_events`), and powers executive dashboards and economic recovery models.
