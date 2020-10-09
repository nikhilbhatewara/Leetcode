


with totalactiviyCTE as (

select user_id,activity_date,count(activity_type) as totalactivity
from activity
group by user_id,activity_date
),

 activeusersCTE as (
select user_id,activity_date
from totalactiviyCTE
where totalactivity >= 1 and activity_date >= "2019-06-28"  and activity_date <= "2019-07-27" 
)

select activity_date as day, count(user_id) as active_users
from activeusersCTE
group by activity_date;


-- better solution
-- since there is an entry in the table, all users are bydefault active

select activity_date as day, count(distinct user_id) as active_users 
from Activity
where datediff('2019-07-27', activity_date) <30
group by activity_date
