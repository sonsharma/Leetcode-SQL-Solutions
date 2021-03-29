# https://leetcode.com/problems/median-employee-salary/

WITH CTE as (
    SELECT *, 
    row_number() OVER (partition by Company Order by Salary, Id) as row_num
FROM Employee),

CTE2 as (SELECT Company,
         if(max(row_num)%2=0, max(row_num) div 2, (max(row_num) div 2) +1) as row1,
         if(max(row_num)%2=0, max(row_num) div 2+1, '#') as row2
         FROM CTE GROUP BY Company)

SELECT 
    c1.Id, c1.Company, c1.Salary
FROM CTE c1 LEFT JOIN CTE2 c2 ON c1.company = c2.company
WHERE c1.row_num = row1 or c1.row_num = row2
;



#Another solution
WITH CTE AS (SELECT
            *,
            ROW_NUMBER() OVER (Partition by Company Order by Salary) row_num
        FROM Employee),
    CTE2 AS (SELECT company, max(row_num) as row_num
            FROM CTE
            GROUP BY Company)
SELECT
    c1.Id,
    c1.Company,
    c1.Salary
FROM CTE c1 JOIN CTE2 c2 
    ON c1.Company = c2.Company 
WHERE c1.row_num = ceil(c2.row_num/2) or (c2.row_num % 2 = 0 and c1.row_num = c2.row_num/2+1)