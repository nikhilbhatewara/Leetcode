WITH RECURSIVE CTE (month) AS
(
  SELECT 1 AS month
  UNION ALL
  SELECT month + 1 FROM CTE WHERE month < 12
)

SELECT 
  month,
  IFNULL(MAX(active_drivers),0) AS active_drivers,
  IFNULL(accepted_rides,0) AS accepted_rides
FROM CTE 
LEFT JOIN 
(
  SELECT
    YEAR(requested_at) AS YYYY,
    YEAR(requested_at)*100+MONTH(requested_at) AS YYYYMM,
    COUNT(ride_id) AS accepted_rides
  FROM Rides
  WHERE ride_id IN (SELECT ride_id FROM AcceptedRides)
  GROUP BY YEAR(requested_at),YEAR(requested_at)*100+MONTH(requested_at)
) R ON CTE.month = R.YYYYMM - R.YYYY*100 AND R.YYYY = 2020
LEFT JOIN 
(
  SELECT
    YEAR(join_date) AS YYYY,
    YEAR(join_date)*100+MONTH(join_date) AS YYYYMM,
    COUNT(driver_id) OVER(ORDER BY YEAR(join_date)*100+MONTH(join_date) ASC) AS active_drivers
  FROM Drivers
) D ON CTE.month >= D.YYYYMM - D.YYYY*100 AND D.YYYY = 2020
GROUP BY month,IFNULL(accepted_rides,0)
ORDER BY 1 ASC
SQL Server

WITH CTE AS
(
  SELECT 1 AS month
  UNION ALL
  SELECT month + 1 FROM CTE WHERE month < 12
)

SELECT 
  month,
  ISNULL(MAX(active_drivers),0) AS active_drivers,
  ISNULL(accepted_rides,0) AS accepted_rides
FROM CTE 
LEFT JOIN 
(
  SELECT
    YEAR(requested_at) AS YYYY,
    YEAR(requested_at)*100+MONTH(requested_at) AS YYYYMM,
    COUNT(ride_id) AS accepted_rides
  FROM Rides
  WHERE ride_id IN (SELECT ride_id FROM AcceptedRides)
  GROUP BY YEAR(requested_at),YEAR(requested_at)*100+MONTH(requested_at)
) R ON CTE.month = R.YYYYMM - R.YYYY*100 AND R.YYYY = 2020
LEFT JOIN 
(
  SELECT
    YEAR(join_date) AS YYYY,
    YEAR(join_date)*100+MONTH(join_date) AS YYYYMM,
    COUNT(driver_id) OVER(ORDER BY YEAR(join_date)*100+MONTH(join_date) ASC) AS active_drivers
  FROM Drivers
) D ON CTE.month >= D.YYYYMM - D.YYYY*100 AND D.YYYY = 2020
GROUP BY month,ISNULL(accepted_rides,0)
ORDER BY 1 ASC



---------------------

generate month table
(select 1 as month)
union (select 2 as month)
union (select 3 as month)
union (select 4 as month)
union (select 5 as month)
union (select 6 as month)
union (select 7 as month)
union (select 8 as month)
union (select 9 as month)
union (select 10 as month)
union (select 11 as month)
union (select 12 as month)
generate driver table (columns: driver_id and month (2020))
select driver_id, 
(case when year(join_date)=2019 then '1' else month(join_date) end) `month`
from Drivers 
where year(join_date)<=2020
generate accepted ride table (columns: ride_id and month (2020))
select month(requested_at) as `month`, a.ride_id
from AcceptedRides a 
join Rides r
on r.ride_id = a.ride_id
where year(requested_at)=2020
combine them
select t.month, 
count(distinct driver_id) active_drivers,
count(distinct rides.ride_id) accepted_rides 
from
(
    (select 1 as month)
    union (select 2 as month)
    union (select 3 as month)
    union (select 4 as month)
    union (select 5 as month)
    union (select 6 as month)
    union (select 7 as month)
    union (select 8 as month)
    union (select 9 as month)
    union (select 10 as month)
    union (select 11 as month)
    union (select 12 as month)
) t
# join driver table
left join
(
	select driver_id, 
	(case when year(join_date)=2019 then '1' else month(join_date) end) `month`
	from Drivers 
	where year(join_date)<=2020
) d
on d.month <= t.month
# join accepted ride table
left join
(
    select month(requested_at) as `month`, a.ride_id
    from AcceptedRides a 
    join Rides r
    on r.ride_id = a.ride_id
    where year(requested_at)=2020
) rides
on t.month = rides.month
group by t.month 
order by t.month 


--------------------

# Write your MySQL query statement below
WITH RECURSIVE year_cte AS (
# creating a year header
    SELECT MIN(YEAR(join_date)) year, MAX(YEAR(join_date)) max_year
    FROM drivers
    
    UNION ALL
    
    SELECT year + 1, max_year
    FROM year_cte
    WHERE year < max_year
),
header AS (
# adding month to the year header
    SELECT year, 1 month, 12 max_month
    FROM year_cte
    
    UNION ALL
    
    SELECT year, month + 1, max_month
    FROM header
    WHERE month < max_month
),
drivers_count AS(
# count newly registered drivers by year, month
        SELECT MAX(YEAR(join_date)) 'year', MAX(MONTH(join_date)) 'month',
               COUNT(driver_id) drivers_count
        FROM drivers
        GROUP BY LEFT(join_date, 7)
),
rides_count AS (
# count accepted rides per year, month
        SELECT MAX(YEAR(r.requested_at)) 'year', MAX(MONTH(r.requested_at)) 'month',
               COUNT(a.ride_id) accepted_rides
        FROM rides r LEFT JOIN acceptedrides a ON r.ride_id = a.ride_id
        GROUP BY LEFT(r.requested_at, 7)    
)
# filter the final table by year, can be easily modified to reflect the number for other years
SELECT month, active_drivers, accepted_rides
FROM (
	# join the the second and third table to the full header, sum over the window to give cumulative count of drivers
    SELECT t1.month, t1.year,
            IFNULL(SUM(t2.drivers_count) OVER (ORDER BY t1.year, t1.month), 0) active_drivers, 
            IFNULL(t3.accepted_rides, 0) accepted_rides
    FROM header t1 LEFT JOIN drivers_count t2 ON t1.year = t2.year AND t1.month = t2.month 
                   LEFT JOIN rides_count t3 ON t1.year = t3.year AND t1.month = t3.month
) temp
WHERE year = 2020
; 
