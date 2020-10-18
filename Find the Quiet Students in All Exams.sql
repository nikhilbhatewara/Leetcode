# Write your MySQL query statement below


/*
- find the students who took atleast 1 exam => inner join
- find the students who scored the highest and lowest score for each exam
    => create a ranking using dense rank for each exam
    => Based on ranking select student who scored highest and lowest score 
- exclude students of #2 from #1
*/


with eligibleStudents as 
(
    select student_id,student_name
    from Student
    where student_id in (select distinct student_id from exam)

)

, rankedScore as (
select exam_id, 
    student_id,
    score,
    dense_rank() over(partition by exam_id order by score desc) highest_score_rank, 
    dense_rank() over(partition by exam_id order by score asc) lowest_score_rank 
from Exam
)


,highest_lowest_Students as (

    select distinct student_id
    from rankedScore
    where highest_score_rank = 1 or lowest_score_rank = 1

)



select *
from eligibleStudents
where student_id not in (

select student_id 
    from highest_lowest_Students

)
