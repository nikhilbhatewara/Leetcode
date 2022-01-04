# Write your MySQL query statement below

# find all friends of each other

select friend_1 as id,friends_count as num
from 
(
select friend_1,count(distinct friend_2) as friends_count, dense_rank() over(order by count(distinct friend_2) desc) as rnk
from
(
select requester_id as friend_1,accepter_id as friend_2
from RequestAccepted
union
select accepter_id as friend_1,requester_id as friend_2
from RequestAccepted
) a
group by 1
) b
where rnk = 1
;
