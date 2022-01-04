with ct as (
    select 
        visited_on,
        sum(amount) as amount
    from Customer
    group by visited_on)


select
    c1.visited_on,
    sum(c2.amount) as amount,
    round(avg(c2.amount), 2) as average_amount
from ct c1, ct c2
where datediff(c1.visited_on, c2.visited_on)  between 0 and 6
group by c1.visited_on
having count(c2.visited_on) = 7

/*
-------- 
Alternative solution
----------
*/

# Write your MySQL query statement below

with agg_sum as
(

select visited_on,sum(amount) as amount
    from Customer
    group by 1

)


select visited_on,amount,average_amount
from
(
select visited_on,
sum(amount) over(order by visited_on  rows between 6 PRECEDING and current row) as amount,
round(avg(amount) over(order by visited_on  rows between 6 PRECEDING and current row),2)  as average_amount,
row_number() over(order by visited_on asc) as r_number
from agg_sum
order by 1 asc
) a
where r_number > 6;
