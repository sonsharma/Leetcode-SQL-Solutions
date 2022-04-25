-- https://leetcode.com/problems/active-users/

-- distinct id, login_date from logins table
-- check current login_date + 5 days = next login_date after 5 rows
-- return distinct id of users + get names from accounts
-- order by ID

WITH CTE AS (SELECT 
                id,
                login_date
            FROM Logins
            GROUP BY id, login_date)

SELECT 
    l.id, a.name
FROM (SELECT 
    id,
    IF(datediff(LEAD(login_date, 4) OVER (PARTITION BY id ORDER BY login_date), login_date) = 4, 1, 0)  as flag
FROM CTE) l LEFT JOIN Accounts a USING(id)
WHERE flag = 1
GROUP BY l.id
ORDER BY l.id

-- Another solution
WITH CTE AS (SELECT
                *,
                ROW_NUMBER() OVER (PARTITION BY id ORDER BY login_date) rowrank
            FROM Logins
            GROUP BY id, login_date)

SELECT 
    DISTINCT c.id, name
FROM CTE c LEFT JOIN Accounts USING(id)
GROUP BY id, DATE_SUB(login_date, INTERVAL rowrank DAY)
HAVING DATEDIFF(max(login_date), min(login_date))+1 >= 5

-- Another solution
SELECT
    l.id,
    MIN(a.name) name
FROM (
    SELECT
        id,
        COUNT(*) OVER (PARTITION BY id ORDER BY login_date RANGE BETWEEN INTERVAL 4 DAY PRECEDING AND CURRENT ROW) num_days
    FROM (SELECT DISTINCT id, login_date FROM Logins) l1 
    ) l LEFT JOIN accounts a USING(id)
WHERE num_days >= 5
GROUP BY 1

