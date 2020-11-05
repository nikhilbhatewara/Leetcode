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



--- better approach



with cte as (
    select 1 as month 
    union all
    select month+1 from cte where month <12
)
SELECT month, ( 
	SELECT COUNT(*) FROM Drivers 
	WHERE join_date < '2021-01-01' AND (join_date < '2020-01-01' OR Month(join_date) <= month)
) as active_drivers, ( 
	SELECT COUNT(*) FROM AcceptedRides, Rides
	WHERE AcceptedRides.ride_id = Rides.ride_id
	AND requested_at < '2021-01-01' AND requested_at >= '2020-01-01' AND Month(requested_at) = month
) as accepted_rides
FROM cte
