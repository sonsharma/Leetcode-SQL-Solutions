# https://leetcode.com/problems/second-degree-follower/

SELECT
    f1.follower, count(DISTINCT f2.follower) as num
FROM Follow f1 INNER JOIN follow f2 ON f1.follower = f2.followee
GROUP BY f1.follower
ORDER BY f1.follower

