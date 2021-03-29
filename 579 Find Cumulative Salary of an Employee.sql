# https://leetcode.com/problems/find-cumulative-salary-of-an-employee/

-- for each ID -> cum salary (3 months) using window function by date range -> partition by ID -> order by month desc
-- for (1) - find out row_number for each month with same logic
-- apply the filter for row_num 2,3,4 
-- order by id asc, month desc


WITH CTE AS (SELECT
                Id,
                Month,
                row_number() OVER (PARTITION BY Id ORDER BY Month desc) as row_num,
                SUM(Salary) OVER (PARTITION BY Id ORDER BY Month desc ROWS BETWEEN current row and 2 following) as cum_sal
            FROM Employee
)

SELECT
    Id,
    Month,
    cum_sal as Salary
FROM CTE
WHERE row_num != 1
ORDER BY Id, Month desc

#Another solution (slightly different)
WITH CTE AS (SELECT
    id,
    month,
    DENSE_RANK() OVER (PARTITION BY Id ORDER BY month desc) monthRank,
    SUM(Salary) OVER (PARTITION BY Id ORDER BY month rows between 2 preceding and current row) cumSalary
FROM Employee)

SELECT
    id,
    month,
    cumSalary as Salary
FROM CTE 
WHERE monthRank != 1
ORDER BY Id, month desc