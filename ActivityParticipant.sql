# Write your MySQL query statement below

/*
1. compute max and min no of participant
2. compare no of people performing activity with max and min no
3. Return activity


*/


with totalCTE as 
(
select activity,count(*) as total_count
from friends
group by activity
)

select activity
from friends
group by activity
having count(*) < (select max(total_count) from totalCTE)
and count(*) > (select min(total_count) from totalCTE)
;




