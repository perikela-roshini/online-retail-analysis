-- Dataset summary
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT InvoiceNo) AS total_invoices,
    COUNT(DISTINCT CustomerID) AS total_customers,
    ROUND(SUM(Revenue), 2) AS total_revenue
FROM online_retail_clean;
-- monthly revenue trend
select date_format(InvoiceDate,'%Y-%m') as Month,
round(sum(Revenue),2) as monthly_revenue
from online_retail_clean
group by Month
order by Month;
-- Top 10 countries by revenue 
select Country , round(sum(Revenue),2) as country_revenue
from online_retail_clean
group by Country
order by country_revenue desc
limit 10;
-- Top 10 customers by revenue
select CustomerID , round(sum(Revenue),2) as customer_revenue
from online_retail_clean
where CustomerID is not null and CustomerID <>0
group by CustomerID
order by customer_revenue desc
limit 10;
-- Top 10 products by revenue
select Description, round(sum(Revenue),2) as product_revenue
from online_retail_clean
group by Description
order by product_revenue desc
limit 10;
-- Average Order Value 
SELECT 
    ROUND(SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2) AS avg_order_value
FROM online_retail_clean;
-- Repeat vs one-time customers
select 
    CASE 
        WHEN invoice_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT 
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS invoice_count
    FROM online_retail_clean
    GROUP BY CustomerID
) t
GROUP BY customer_type;
