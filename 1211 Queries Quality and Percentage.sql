# https://leetcode.com/problems/queries-quality-and-percentage/

SELECT
    query_name, 
    round(avg(rating/position), 2) as quality,
    round(sum(if(rating < 3, 1, 0))*100/count(*), 2) as poor_query_percentage
FROM
    Queries
GROUP BY query_name