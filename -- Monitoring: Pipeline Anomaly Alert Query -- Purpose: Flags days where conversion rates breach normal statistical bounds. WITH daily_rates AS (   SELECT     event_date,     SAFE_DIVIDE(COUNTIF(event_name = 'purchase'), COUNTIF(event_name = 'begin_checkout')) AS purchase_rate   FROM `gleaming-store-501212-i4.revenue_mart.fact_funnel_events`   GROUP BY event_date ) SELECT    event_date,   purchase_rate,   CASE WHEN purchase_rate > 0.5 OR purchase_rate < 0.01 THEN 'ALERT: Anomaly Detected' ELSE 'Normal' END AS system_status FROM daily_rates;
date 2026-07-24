-- Monitoring: Pipeline Anomaly Alert Query
-- Purpose: Flags days where conversion rates breach normal statistical bounds.
WITH daily_rates AS (
  SELECT
    event_date,
    SAFE_DIVIDE(COUNTIF(event_name = 'purchase'), COUNTIF(event_name = 'begin_checkout')) AS purchase_rate
  FROM `gleaming-store-501212-i4.revenue_mart.fact_funnel_events`
  GROUP BY event_date
)
SELECT 
  event_date,
  purchase_rate,
  CASE WHEN purchase_rate > 0.5 OR purchase_rate < 0.01 THEN 'ALERT: Anomaly Detected' ELSE 'Normal' END AS system_status
FROM daily_rates;
