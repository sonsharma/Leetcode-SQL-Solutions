# https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/

SELECT
    customer_id, count(*) as count_no_trans
FROM Visits v
WHERE visit_id NOT IN (SELECT DISTINCT visit_id FROM Transactions)
GROUP BY customer_id
;