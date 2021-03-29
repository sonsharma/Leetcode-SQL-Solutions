#https://leetcode.com/problems/find-median-given-frequency-of-numbers/
z  
WITH CTE as (SELECT 
    Number,
    frequency,
    sum(frequency) over (order by number) as fsum,
    (sum(frequency) over ())/2 as median
FROM Numbers)

SELECT
    avg(number) as median
FROM CTE 
WHERE median between fsum - frequency and fsum