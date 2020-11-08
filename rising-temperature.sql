# Write your MySQL query statement below


select w1.Id
from Weather w1
inner join Weather w2
on datediff(w1.recordDate,w2.recordDate) = 1
and w1.temperature > w2.temperature 



-- window function

select Id_INT_
from
(

SELECT Id_INT_,RecordDate_DATE_,Temperature_INT_
,lag(Temperature_INT_,1) over() as prev_temp
FROM Weather
  ) as T
  where Temperature_INT_ > prev_temp
