# Write your MySQL query statement below

with availablebooks as 
(
select *
    from books
    where available_from < "2019-05-23"

)


, copiessold as
(
select book_id, sum(quantity)  as  totalcopies
    from orders
    where dispatch_date between  "2018-06-23" and "2019-06-23"
    group by book_id
    having totalcopies >= 10
    

)


select book_id,name
from availablebooks a
where book_id not in (select book_id from copiessold)

