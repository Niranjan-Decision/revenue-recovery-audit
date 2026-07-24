-- Transformation: Silver Layer Fact Sales Transactions
-- Purpose: Flattens nested GA4 parameters and secures multi-row aggregation safety.
CREATE OR REPLACE TABLE `gleaming-store-501212-i4.revenue_mart.fact_sales_transactions` AS
SELECT
  event_date,
  user_pseudo_id,
  MAX(event_timestamp) AS event_time,
  MAX(CASE WHEN key = 'ga_session_id' THEN value.int_value END) AS session_id,
  MAX(CASE WHEN key = 'transaction_id' THEN value.string_value END) AS transaction_id,
  MAX(CASE WHEN key = 'value' THEN value.double_value END) AS revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(event_params)
WHERE event_name = 'purchase'
GROUP BY event_date, user_pseudo_id, event_timestamp
HAVING transaction_id IS NOT NULL;
