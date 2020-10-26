
/*

sort table in asc order
absolute difference between 2 consecutive numbers 
min of the difference

*/



select min(abs(a.x - b.x)) as shortest
from point a
cross join point b
on a.x != b.x
