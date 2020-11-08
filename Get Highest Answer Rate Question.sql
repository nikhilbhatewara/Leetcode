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

-- if a question has same answer rate then the above method will not work, use dense rank
/*
1. For each question calculate no of answers and no of shows(case when)
2. Compute the ration (divide the no of answers by no of shows)
3. order by ratio (order by desc)
4. limit 1
*/

with CTE1 as 
(
SELECT question_id,
sum(case when action = "answer"  then 1 else 0 end) as no_of_answers,
sum(case when action = "show"  then 1 else 0 end) as no_of_shows
FROM Input
group by question_id
)

, CTE2 as
(

  SELECT question_id,round(no_of_answers/no_of_shows,2) as answer_ratio
  from CTE1
)
# what if we have 2 questions with same answer rate
,  CTE3 as
( 
  select question_id,dense_rank() over(order by answer_ratio desc)  answer_ratio_rank
  from CTE2
 )
 select question_id
 from CTE3
 where answer_ratio_rank = 1
  
