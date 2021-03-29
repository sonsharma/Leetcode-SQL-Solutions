# https://leetcode.com/problems/article-views-ii/submissions/

SELECT
    DISTINCT viewer_id as id 
FROM Views
GROUP BY viewer_id, view_date
HAVING count(DISTINCT article_id) > 1
ORDER BY viewer_id
;