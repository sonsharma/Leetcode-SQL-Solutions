#https://leetcode.com/problems/reported-posts-ii/

WITH CTE AS (SELECT *
FROM Actions a LEFT JOIN Removals r USING(post_id)
WHERE extra='spam')

SELECT ROUND(AVG(av)*100, 2) as average_daily_percent
FROM (SELECT
    COUNT(DISTINCT CASE WHEN remove_date is not null
        THEN post_id END)/COUNT(DISTINCT post_id) as av
FROM CTE 
GROUP BY action_date
) s;