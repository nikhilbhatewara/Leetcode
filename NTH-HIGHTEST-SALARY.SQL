
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      with CTE as 
      (
      SELECT Salary , DENSE_RANK() OVER ( ORDER BY Salary  DESC) MY_RANK FROM Employee 
      )
      # IF MULTIPLE ROWS EXISTS FOR THE Nth ROW, RETURN THE MAX SALARY VALUE
      SELECT MAX(Salary) 
      FROM CTE
      WHERE MY_RANK  = N
  );
END


