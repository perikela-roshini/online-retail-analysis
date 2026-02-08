DROP TABLE IF EXISTS online_retail_clean;

CREATE TABLE online_retail_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    CAST(Quantity AS SIGNED)      AS Quantity,
    STR_TO_DATE(InvoiceDate, '%Y-%m-%d %H:%i:%s') AS InvoiceDate,
    CAST(UnitPrice AS DECIMAL(10,2)) AS UnitPrice,
    CustomerID,
    Country
FROM online_retail
WHERE
    Quantity > 0
    AND UnitPrice > 0
    AND InvoiceNo NOT LIKE 'C%';
select count(*) from online_retail_clean;
select * from online_retail_clean 
limit 5;
alter table online_retail_clean 
add column Revenue decimal(12,2);
describe online_retail_clean;
update online_retail_clean 
set Revenue = Quantity * UnitPrice
where Revenue is null;
set sql_safe_updates = 0;
set sql_safe_updates = 1;
select * from online_retail_clean 
where Revenue is null;
select min(Revenue) , max(Revenue) 
from online_retail_clean;
