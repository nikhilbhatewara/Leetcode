# Write your MySQL query statement below


with logins as
(
select user_id,activity_date , dense_rank() over(partition by user_id order by activity_date asc) logindays
from traffic
where activity = "login"
)


, firstlogins as
(
select user_id,activity_date
from logins
where logindays = 1 and datediff("2019-06-30",activity_date) <= 90
)


select activity_date as login_date, count(distinct user_id) as user_count
from firstlogins
group by activity_date
having count(distinct user_id) > 0;

-- smaller approach
select login_date, count(1) user_count
from
(select user_id, min(activity_date) login_date
from traffic
where activity = 'login'
group by user_id) a
where login_date between date_add('2019-06-30', interval -90 day) and '2019-06-30'
group by login_date




-- another approach
/*
Find first login date for each user
filter for 90 days 
take count
*/

with cte1 as
(
SELECT user_id,min(activity_date) as first_login
FROM Traffic
where activity = "login"
group by user_id
)


select first_login as login_date, count(*)
from cte1
group by first_login
having first_login between "2019-03-30" and "2019-06-30"
order by first_login asc
