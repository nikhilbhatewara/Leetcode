# Write your MySQL query statement below

/*
1. compute average occurence for each event type

2. for each business id, check if the occurence of event type is ge the average 

3. if count from step 2 is ge 2 then return business id

*/

with CTE as
(
select event_type, sum(occurences)/count(*) as average
from events
group by event_type
)

, CTE2 as (
select e.business_id,e.event_type,e.occurences
from events e
left join CTE c
on e.event_type = c.event_type
where e.occurences > c.average
)


select business_id
from CTE2
group by business_id
having count(business_id) >= 2;

-- better approach

select business_id                                      # Finally, select 'business_id'
from
(select event_type, avg(occurences) as ave_occurences   # First, take the average of 'occurences' group by 'event_type'
 from events as e1
 group by event_type
) as temp1
join events as e2 on temp1.event_type = e2.event_type   # Second, join Events table on 'event_type'
where e2.occurences > temp1.ave_occurences              # Third, the 'occurences' should be greater than the average of 'occurences'
group by business_id
having count(distinct temp1.event_type) > 1             # (More than one event type with 'occurences' greater than 1)
