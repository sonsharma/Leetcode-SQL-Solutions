# https://leetcode.com/problems/find-customer-referee/

SELECT
    name
FROM
    customer
WHERE COALESCE(referee_id, 0) <> 2;

#Another solution
SELECT
    name
FROM customer
WHERE referee_id <> 2 or referee_id is null