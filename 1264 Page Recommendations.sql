# https://leetcode.com/problems/page-recommendations/

-- get frnds of userid 1
-- get pages liked by (1)
-- removes pages liked by user_id 1 from (2)

WITH CTE as (SELECT
                DISTINCT IF(user1_id = 1, user2_id, user1_id) as friends
            FROM Friendship 
            WHERE user1_id = 1 or user2_id = 1)
SELECT 
    DISTINCT page_id as recommended_page
FROM Likes
WHERE user_id IN (SELECT * FROM CTE)
and page_id not in (SELECT page_id FROM Likes where user_id = 1)
;