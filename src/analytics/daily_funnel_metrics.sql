-- Analytics: Daily Funnel Metrics Aggregation
-- Purpose: Summarizes user progression volumes from product view to purchase.
CREATE OR REPLACE TABLE `gleaming-store-501212-i4.revenue_mart.daily_funnel_metrics` AS
SELECT
  event_date,
  COUNTIF(event_name = 'view_item') AS view_item_count,
  COUNTIF(event_name = 'add_to_cart') AS add_to_cart_count,
  COUNTIF(event_name = 'begin_checkout') AS begin_checkout_count,
  COUNTIF(event_name = 'purchase') AS total_purchase_events,
  SUM(CASE WHEN event_name = 'purchase' THEN (SELECT value.double_value FROM UNNEST(event_params) WHERE key = 'value') END) AS total_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY 1
ORDER BY 1 DESC;
