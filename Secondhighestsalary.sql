# Write your MySQL query statement below

SELECT MAX(SALARY) AS SecondHighestSalary
FROM EMPLOYEE
WHERE SALARY < (
SELECT MAX(SALARY) AS MSAL
FROM EMPLOYEE)