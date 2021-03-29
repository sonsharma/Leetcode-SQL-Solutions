# https://leetcode.com/problems/countries-you-can-safely-invest-in/

-- find countries for caller & callee and make a single table with countries and duration
-- find out global avg, avg for each country
-- compare and return the final answer

WITH CTE AS (SELECT caller_id as id, duration FROM Calls
                    UNION ALL
                    SELECT callee_id as id, duration FROM Calls),
                    
    callers AS (SELECT 
                     LEFT(p.phone_number, 3) as country_code,
                     AVG(duration) OVER (PARTITION BY LEFT(p.phone_number, 3)) as coun_avg,
                     AVG(duration) OVER() as global_avg
               FROM CTE c LEFT JOIN Person p USING(id)
               ) 
               
SELECT
    DISTINCT name as country
FROM callers LEFT JOIN Country USING(country_code)
WHERE coun_avg > global_avg
;