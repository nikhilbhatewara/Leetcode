# Write your MySQL query statement below


with CTE1 as (
select ad_id,
sum(case when action = "Clicked" then "1" else "0" end) as totalclicked,
sum(case when action = "Viewed" then "1" else "0" end) as totalviewed
from ads
group by ad_id
)


select ad_id, 
case when totalclicked != 0 then 
round(100 * (totalclicked/(totalclicked+totalviewed)),2)
else 0.00 end as ctr
from CTE1
order by ctr desc,ad_id


