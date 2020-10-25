# Write your MySQL query statement below

/*
Assign group to each player
split the table between first and second player

for each group, create a dense rank based on total score
select palyer with rank = 1


*/

with pgroups as (

select b.group_id, b.player_id,a.first_score as score
from matches a
join players b
on a.first_player = b.player_id

union all

select b.group_id, b.player_id,a.second_score as score
from matches a
join players b
on a.second_player = b.player_id
)

, CTE2 as (
select group_id,player_id,score, dense_rank() over (partition by group_id order by sum(score) desc,player_id asc) scorerank
from pgroups
group by group_id,player_id
)

select group_id,player_id
from CTE2
where scorerank = 1


