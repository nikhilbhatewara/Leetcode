# Write your MySQL query statement below
SELECT A.FirstName, A.LastName, B.City, B.State
FROM PERSON A 
LEFT JOIN ADDRESS B ON A.PERSONID = B.PERSONID;
