-- Decision Model: Integrity Lock & Conversion Cap Rules
-- Purpose: Neutralizes client-side tracking inflation where checkout rates exceed 100%.
SELECT
  event_date,
  SAFE_DIVIDE(
    COUNT_DISTINCT(CASE WHEN event_name = 'begin_checkout' THEN session_id END),
    NULLIF(COUNT_DISTINCT(CASE WHEN event_name = 'add_to_cart' THEN session_id END), 0)
  ) AS raw_checkout_rate,
  CASE 
    WHEN SAFE_DIVIDE(COUNT_DISTINCT(CASE WHEN event_name = 'begin_checkout' THEN session_id END), 
                     NULLIF(COUNT_DISTINCT(CASE WHEN event_name = 'add_to_cart' THEN session_id END), 0)) > 1 
    THEN 1.0 
    ELSE SAFE_DIVIDE(COUNT_DISTINCT(CASE WHEN event_name = 'begin_checkout' THEN session_id END), 
                     NULLIF(COUNT_DISTINCT(CASE WHEN event_name = 'add_to_cart' THEN session_id END), 0)) 
  END AS locked_checkout_rate
FROM `gleaming-store-501212-i4.revenue_mart.fact_funnel_events`
GROUP BY event_date;
