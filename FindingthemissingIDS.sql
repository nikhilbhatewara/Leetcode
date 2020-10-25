
WITH RECURSIVE seq AS (
    SELECT 1 AS value UNION ALL SELECT value + 1 FROM seq WHERE value < 100
    )

SELECT value as ids FROM seq
where value < (select max(customer_id) from Customers) and
value not in (select customer_id from Customers) 

;
