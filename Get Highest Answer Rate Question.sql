# Write your MySQL query statement below
/*
For each question, count no of answer
count no of show 
find the ratio
find the question with highest ratio
*/

with counttable as (
    select question_id,
    sum(case when action = "show" then 1 else 0 end) as showcount,
    sum(case when action = "answer" then 1 else 0 end) as actioncount
    from survey_log
    group by question_id
)


select question_id as survey_log
from
(
    
    select question_id, actioncount/showcount as answerrate
    from counttable
    
    
) as T
order by answerrate desc
limit 1


