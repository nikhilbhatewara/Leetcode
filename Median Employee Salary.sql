# Write your MySQL query statement below




with t1 as
(
    
select *, row_number() over(partition by Company order by Salary) as rnumber,
count(Id) over(partition by Company) as cnt
from Employee 
)

select Id, Company, Salary
from t1
where rnumber between cnt/2.0 and cnt/2.0+1;
