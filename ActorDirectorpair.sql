# Write your MySQL query statement below



select distinct actor_id,director_id
from (

select actor_id,director_id,count(*)
from actordirector
group by actor_id,director_id
having count(*) >= 3
    ) as T;
