# https://leetcode.com/problems/activity-participants/

-- for each activity -> how many frnds have performed it
-- rank each activity based on (1) - rank
-- remove ID of activity from result  where ID =(get ID of max and min rank in (2) )

WITH CTE AS (SELECT activity, 
        rank() OVER (ORDER BY count(id) desc) as act_rank1,
        rank() OVER (ORDER BY count(id)) as act_rank2
        FROM Friends
        GROUP BY activity)
            
SELECT activity
FROM CTE
WHERE act_rank1 = 1 or act_rank2 = 1
;

#Other way

SELECT 
    activity
FROM (SELECT
            activity,
            RANK() OVER (ORDER BY COUNT(id)) as ascRank,
            RANK() OVER (ORDER BY COUNT(id) desc) as descRank
        FROM Friends
        GROUP BY 1) f
WHERE ascRank != 1 and descRank != 1