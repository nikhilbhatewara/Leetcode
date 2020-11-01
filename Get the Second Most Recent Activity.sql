# Write your MySQL query statement below


with recentactivity as 
(
select *,dense_rank() over(partition by username order by endDate desc) recency
from useractivity
)


,  activitycount as 
(
    select username        , count(recency) as rcount
    from recentactivity
    group by username      
)

, onlyOneActivity as 
(
    select username   , activity     , startDate   , endDate

    from recentactivity

    where  username NOT IN 
            (
                # exclude user,activity pair for more than 1 activity
                select  username    
                from activitycount
                where rcount > 1
                
            )


)






# when we have more than 1 activity
    
    select username   , activity     , startDate   , endDate     
    from recentactivity
    where recency = 2
    
    union
    
    select username   , activity     , startDate   , endDate
    from onlyOneActivity


-- better approach

select username, activity, startDate, endDate
from (
  select *, 
  count(activity) over(partition by username)cnt, 
  ROW_NUMBER() over(partition by username order by startdate desc) n 
  from UserActivity) tbl
where n=2 or cnt<2

