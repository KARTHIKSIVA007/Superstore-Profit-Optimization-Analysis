
-- PHASE 1: DATA VERIFICATION

SELECT COUNT(*) AS total_rows FROM orders;



-- PHASE 2: BUSINESS ANALYSIS QUERIES

-- 1. Regional Profitability
SELECT 
    "Region",
    ROUND(SUM("Sales")::numeric, 2) AS total_sales,
    ROUND(SUM("Profit")::numeric, 2) AS total_profit,
    ROUND((SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100)::numeric, 2) AS profit_margin_percentage
FROM orders
GROUP BY "Region"
ORDER BY profit_margin_percentage Desc;

-- 2. Category Analysis
SELECT 
    "Category",
    "Sub-Category",
    ROUND(SUM("Sales")::numeric, 2) AS total_sales,
    ROUND(SUM("Profit")::numeric, 2) AS total_profit,
    ROUND(AVG("Discount")::numeric, 4) AS avg_discount
FROM orders
GROUP BY "Category", "Sub-Category"
ORDER BY total_profit ASC;

-- 3. Discount Impact Analysis (Correlation Check)
SELECT 
    CASE 
        WHEN "Discount" = 0 THEN 'No Discount'
        WHEN "Discount" <= 0.2 THEN 'Low (0-20%)'
        WHEN "Discount" <= 0.5 THEN 'Medium (21-50%)'
        ELSE 'High (>50%)'
    END AS discount_bracket,
    COUNT(*) AS order_count,
    ROUND(AVG("Profit")::numeric, 2) AS avg_profit_per_order
FROM orders
GROUP BY 1
ORDER BY 2 Desc;

-- 4. Top Selling Products per Region (Window Function)
WITH RegionalRanking AS (
    SELECT 
        "Region",
        "Sub-Category",
        SUM("Sales") AS total_sales,
        RANK() OVER (PARTITION BY "Region" ORDER BY SUM("Sales") DESC) as sales_rank
    FROM orders
    GROUP BY "Region", "Sub-Category"
)
SELECT "Region", "Sub-Category", ROUND(total_sales::numeric, 2) AS top_sales
FROM RegionalRanking
WHERE sales_rank = 1;

-- 5. Geographic Deep Dive
SELECT 
    "State",
    ROUND(SUM("Profit")::numeric, 2) AS net_profit
FROM orders
WHERE "Sub-Category" = 'Tables'
GROUP BY "State"
HAVING SUM("Profit") < 0
ORDER BY net_profit ASC
LIMIT 10;