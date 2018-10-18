select distinct s1.id as id,s1.date as date, s1.people as people
from stadium s1,stadium s2, stadium s3
where s1.people > 99 and s2.people > 99 and s3.people > 99 and ((s1.id = s2.id - 1 and s2.id = s3.id -1) or (s2.id = s1.id - 1 and s2.id = s3.id - 2) or (s1.id = s3.id + 2 and s2.id = s3.id + 1))
order by s1.id;
