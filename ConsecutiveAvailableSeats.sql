# Write your MySQL query statement below


/*

if seat_id has a free seat and seat_id+1 has a free seat then return seat_id



seat_id1 | free1 | seat_id2 | free2
    1       1       2           0
    2       0       3           1
    3       1       4           1
    4       1       5           1
    5       1
    
*/    
    
select seat_id 
from (

select c1.seat_id 
from cinema c1
join cinema c2
on c1.seat_id = c2.seat_id+1
and c1.free = 1 and c2.free=1

union

select c2.seat_id
from cinema c1
join cinema c2
on c1.seat_id = c2.seat_id+1
and c1.free = 1 and c2.free=1
) as t
order by seat_id


;




/* 
Better appraoch
*/
select distinct c1.seat_id
from cinema c1,
cinema c2
where (c1.seat_id+1 = c2.seat_id or
c1.seat_id - 1 = c2.seat_id)
and c1.free = '1'
and c2.free = '1'
order by c1.seat_id;
