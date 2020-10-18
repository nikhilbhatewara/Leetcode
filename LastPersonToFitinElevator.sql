


select person_name
from 
(

select person_name,sum(weight) over (order by turn) as RunningWeight
from Queue

) as T
where RunningWeight <= 1000
order by RunningWeight desc
limit 1
    
    
    ;
