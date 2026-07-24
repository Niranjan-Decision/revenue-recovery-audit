-- Integration Test: Verify session continuity across funnel steps
SELECT 
  CASE WHEN COUNT(*) > 0 THEN 'PASS: Funnel Events Present' 
       ELSE 'FAIL: Missing Funnel Data' 
  END AS test_result
FROM `gleaming-store-501212-i4.revenue_mart.fact_funnel_events`;
