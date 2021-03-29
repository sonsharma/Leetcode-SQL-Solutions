# https://leetcode.com/problems/percentage-of-users-attended-a-contest/

SELECT
    contest_id, 
    round(count(*)*100/users_count, 2) percentage
FROM
    Register r, (SELECT count(*) as users_count FROM USERS) temp
GROUP BY contest_id
ORDER BY 2 desc, 1