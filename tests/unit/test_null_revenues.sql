-- Unit Test: Verify zero null-revenue records in processed sales table
SELECT 
  CASE WHEN COUNTIF(revenue IS NULL) = 0 THEN 'PASS: Zero Null Revenues' 
       ELSE 'FAIL: Null Revenue Detected' 
  END AS test_result
FROM `gleaming-store-501212-i4.revenue_mart.fact_sales_transactions`;
