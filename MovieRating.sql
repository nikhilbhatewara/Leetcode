# Write your MySQL query statement below
#Use limit to select only 1 name

(
select b.name  as results
from 
(
    select user_id, dense_rank() over(order by count(movie_id) desc) userratingrank
    from movie_rating
    group by user_id
) as t1
join users b
on t1.user_id = b.user_id
where userratingrank = 1
order by b.name asc 
limit 1
)


union all

(
select b.title as results
from
(
    select movie_id, dense_rank() over (order by avg(rating) desc) movieratingrank
    from movie_rating
    where month(created_at) = 02 and year(created_at) = 2020
    group by movie_id
) as t2
join movies b
on t2.movie_id = b.movie_id
where t2.movieratingrank = 1
order by b.title asc
limit 1
    )
