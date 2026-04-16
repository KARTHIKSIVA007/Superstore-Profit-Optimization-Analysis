# Superstore Sales Profitability Analysis
**Role:** Business Analyst  
**Tools:** Python (Pandas, Seaborn), SQL, Power BI  
**Dataset:** Sample Superstore — 9,994 orders (2014–2017)

## Business Problem
The VP of Sales reported declining profitability despite 
steady revenue. I was tasked with identifying root causes 
and providing actionable recommendations.

## Key Findings
- Central region operates at 7.92% margin — 34% below average
- Tables sub-category generated a net loss of $17,725 over 4 years
- Discount correlation with profit: -0.219 (discounts destroy margin)
- Ohio is the highest loss-generating state

## Recommendations
1. Implement discount cap policy (no >30% without manager approval)
2. Review Furniture SKU profitability — discontinue loss items
3. Shift Central region targets from revenue-based to margin-based
4. Audit Ohio market pricing strategy

## Files
- `Notebook/Data Cleaning and analysis.ipynb` — Python analysis
- `Sql/Business Queries.sql` — Business questions in SQL
- `Reports/Superstore_Dashboard.pdf` — Power BI dashboard
- `Reports/Superstore_BA_Report.pdf` — Business recommendation
