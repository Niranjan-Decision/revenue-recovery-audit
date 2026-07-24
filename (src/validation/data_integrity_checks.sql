-- Validation: Schema & Null Revenue Audit
-- Purpose: Identifies tracking failures where purchase events fire without transaction values.
SELECT
  COUNT(*) AS total_purchase_events,
  COUNT(revenue) AS valid_revenue_events,
  COUNTIF(revenue IS NULL) AS ghost_revenue_events,
  SAFE_DIVIDE(COUNTIF(revenue IS NULL), COUNT(*)) AS ghost_rate_percentage
FROM `gleaming-store-501212-i4.revenue_mart.fact_sales_transactions`;
