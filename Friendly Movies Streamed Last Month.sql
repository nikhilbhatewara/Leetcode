select distinct title
from content a
join TVProgram b
on a.content_id = b.content_id
and a.Kids_content = "Y" and a.content_type = "Movies" and year(b.program_date)  = "2020" and month(b.program_date) = "6"

