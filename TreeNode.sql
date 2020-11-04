# Write your MySQL query statement below

/*
root node -> p_id is null
2 shows up in p_id and p_id of 2 is not null=> inner node
3,4,5 does not show up in p_id so left node
*/



select id,case 
when p_id is null then "Root"
when p_id is not null and id in (select p_id from tree where p_id is not null) then "Inner"
when id not in (select p_id from tree where p_id is not null) then "Leaf"
end as Type
from tree
