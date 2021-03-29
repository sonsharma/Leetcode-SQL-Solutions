# https://leetcode.com/problems/find-the-missing-ids/

-- Recursive cte to generate seq of IDs from 1 till max(customer_id)
-- subtract customer_id from (1)

WITH RECURSIVE CTE AS (SELECT 1 as customer_id
                       UNION ALL
                       SELECT customer_id + 1 as customer_id
                       FROM CTE 
                       WHERE customer_id < (SELECT MAX(customer_id) FROM Customers)
                      )
                      
                      
SELECT customer_id as ids
FROM CTE
WHERE customer_id NOT IN (SELECT customer_id FROM Customers)
;