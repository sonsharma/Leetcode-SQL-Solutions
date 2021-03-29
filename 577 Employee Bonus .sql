# https://leetcode.com/problems/employee-bonus/

SELECT
    e.name, s.bonus
FROM
    Employee e 
    LEFT JOIN Bonus s ON e.empId = s.empId 
WHERE s.bonus < 1000 or s.bonus is null
;

# Another solution
SELECT
    name,
    bonus
FROM Employee e LEFT JOIN Bonus b ON e.empId = b.empId 
WHERE COALESCE(bonus, 0) < 1000
GROUP BY 1