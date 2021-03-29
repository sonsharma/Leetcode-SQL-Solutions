# https://leetcode.com/problems/nth-highest-salary/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN

  RETURN (
      # Write your MySQL query statement below.
      SELECT distinct Salary FROM 
        (SELECT
        Salary, dense_rank() OVER (ORDER BY Salary desc) as dr
      FROM
        Employee) s
      where dr = N
      
  );
END

# Another solution
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT
        IFNULL((SELECT DISTINCT Salary
               FROM Employee
               ORDER BY 1 desc
               LIMIT 1 OFFSET N), NULL) as getNthHighestSalary
  );
END