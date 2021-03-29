# https://leetcode.com/problems/top-travellers/

SELECT
    name, ifnull(sum(distance),0) as travelled_distance
FROM
    Users u LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY name
ORDER BY sum(distance) desc, name