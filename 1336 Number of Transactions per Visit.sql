# https://leetcode.com/problems/number-of-transactions-per-visit/

WITH CTE AS (SELECT 
        transactions_count, count(*) as visits_count
    FROM (SELECT 
        count(t.user_id) as transactions_count
    FROM Visits u LEFT JOIN Transactions t ON u.user_id = t.user_id and u.visit_date = t.transaction_date
    GROUP BY u.user_id ,u.visit_date) s
    GROUP BY transactions_count),
    
    CTE2 AS (SELECT row_number() over () as transactions_count
             FROM Transactions
             UNION
             SELECT 0
            )

       
SELECT c1.transactions_count, IF(c2.transactions_count IS NULL, 0, c2.visits_count) as visits_count
FROM CTE2 c1 LEFT JOIN CTE c2 USING(transactions_count)
WHERE c1.transactions_count <= (SELECT max(transactions_count) FROM CTE)
ORDER BY c1.transactions_count
;

# another solution

-- Get transactions_counts + get max value of it
-- Generate seq from 0 to value(1)
-- For each user - get nnumber of transactions per visit they have done
-- merger (2) and (3)

WITH CTE AS (SELECT 
                v.user_id, 
                count(t.transaction_date) as transactions_count
             FROM Visits v LEFT JOIN Transactions t 
                ON v.user_id = t.user_id and v.visit_date = t.transaction_date
             GROUP BY v.user_id, v.visit_date),
             
    Result as (
            WITH Recursive seq AS (select 0 as transactions_count
            union all
            select transactions_count + 1 as transactions_count
            FROM seq 
            where transactions_count < (SELECT max(transactions_count) FROM CTE))
            SELECT * FROM seq)
#select * from cte
SELECT 
    r.transactions_count,
    COUNT(c.user_id) as visits_count
FROM Result r LEFT JOIN CTE c USING(transactions_count)
GROUP BY transactions_count