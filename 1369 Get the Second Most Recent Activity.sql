# https://leetcode.com/problems/get-the-second-most-recent-activity/
SELECT *
FROM UserActivity
GROUP BY username
HAVING count(*) = 1

UNION

SELECT  username, activity, startDate, endDate
FROM (SELECT *, dense_rank() OVER (partition by username order by startDate desc) as urank
FROM UserActivity) u
WHERE urank = 2