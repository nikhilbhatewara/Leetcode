# Write your MySQL query statement below

/*
- Find users of user 1
- find pages liked by friends of user 1 
- exclude pages liked by user 1 from recommendation 
*/


with recommendations as 
(
select b.page_id
from Friendship a
join Likes b
on a.user2_id = b.user_id
where a.user1_id = 1 
    
    union all

select b.page_id
from Friendship a
join Likes b
on a.user1_id = b.user_id
where a.user2_id = 1 
    
    
    
    
)




select distinct page_id as recommended_page
from recommendations
where page_id not in 
(select page_id
    from likes
    where user_id = 1
)




