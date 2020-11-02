# Write your MySQL query statement below

with comments as (
select parent_id , count(distinct sub_id) as number_of_comments
from submissions
where parent_id is not null
group by parent_id 
)

, posts as (

select distinct sub_id
from submissions
where parent_id is Null
)


select sub_id as post_id,coalesce(number_of_comments,0) as number_of_comments
from posts
left join comments 
on posts.sub_id = comments.parent_id
order by sub_id
