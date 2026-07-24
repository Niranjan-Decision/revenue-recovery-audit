-- Ingestion: Raw GA4 Event Stream Connection
-- Purpose: Pulls raw obfuscated public e-commerce event logs using wildcard partitioning.
SELECT
  event_date,
  event_timestamp,
  event_name,
  user_pseudo_id,
  event_params
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';
