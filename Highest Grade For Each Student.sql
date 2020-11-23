/*
dense rank desc grade asc course id
*/

select student_id,course_id,grade
from(
SELECT * ,dense_rank() over(partition by student_id order by grade desc, course_id asc) as stdrank
FROM Enrollments
  ) as t
  where stdrank = 1
