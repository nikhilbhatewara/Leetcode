# Write your MySQL query statement below

/*
for each user id (req,acc) find total no of friends

no of friends of requester
no of friends of accepter
join based on id and club the count for total friends


*/

with cte1 as (

select requester_id as user_id, count(distinct accepter_id) as num
    from request_accepted
    group by requester_id
    union
select accepter_id as user_id, count(distinct requester_id) as num
    from request_accepted
    group by accepter_id 
 
)

,cte2 as (
select user_id,sum(num) as num,dense_rank() over (order by sum(num) desc) as numrank
from cte1
group by user_id
)

select user_id as id, num
from cte2
where numrank = 1

-- better approach

select id1 as id, count(id2) as num
from
(select requester_id as id1, accepter_id as id2 
from request_accepted
union
select accepter_id as id1, requester_id as id2 
from request_accepted) tmp1
group by id1 
order by num desc limit 1
