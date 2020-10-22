# Write your MySQL query statement below

/*
- For each invoice inner join customer table and populate customer name

- for each user_id in contacts, left join customer table 
- count contact_email as cnt_contact
- count customerid as trusted_cnt. Since count will not include null values, coontact count and trusted count may differ. user if null(0) 

- Join #1 with #2 based on user _id

*/

with cte1 as (
select a.invoice_id,b.customer_name,a.price,a.user_id
from invoices a
join customers b
on a.user_id = b.customer_id
)

,cte2 as (

select a.user_id
    , ifnull(count(a.contact_email),0) as contacts_cnt
    , ifnull(count(b.customer_id),0) as trusted_contacts_cnt    
from contacts a
left join customers b
on a.contact_email = b.email
group by a.user_id



)


select invoice_id,customer_name,price,ifnull(contacts_cnt,0) as contacts_cnt ,ifnull(trusted_contacts_cnt,0) as trusted_contacts_cnt
from CTE1 a
left join CTE2 b
on a.user_id = b.user_id
order by invoice_id;




