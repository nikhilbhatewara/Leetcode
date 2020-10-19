          SELECT 
        max(case when continent = "America" then name else null end) as "America",
        max(case when continent = "Asia" then name else null end) as "Asia",
        max(case when continent = "Europe" then name else null end) as "Europe"
        from (
        select *,row_number() over(partition by continent order by name ) as rn
            from student
            order by name
        ) as T1
        group by rn
