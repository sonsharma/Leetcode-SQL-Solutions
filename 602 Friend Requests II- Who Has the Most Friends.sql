-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

SELECT
    r1.requester_id as id, COUNT(DISTINCT r1.accepter_id)+ COUNT(DISTINCT r2.requester_id)  as num
FROM request_accepted r1 LEFT JOIN request_accepted r2
    ON r1.requester_id = r2.accepter_id
GROUP BY r1.requester_id
ORDER BY 2 desc
LIMIT 1

-- Another solution
SELECT
    id,
    COUNT(*) num
FROM (SELECT requester_id id FROM request_accepted
UNION ALL
SELECT accepter_id id FROM request_accepted) f
GROUP BY id
ORDER BY 2 desc
LIMIT 1