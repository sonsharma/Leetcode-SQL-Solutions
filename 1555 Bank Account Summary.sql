# https://leetcode.com/problems/bank-account-summary/

-- For each user - credit, sum(paid), sum(received)
-- find breached or not based on (1)

SELECT 
    user_id,
    user_name,
    credit - SUM(IFNULL(t1.amount, 0)) + SUM(IFNULL(t2.amount, 0)) as credit,
    IF(credit - SUM(IFNULL(t1.amount, 0)) + SUM(IFNULL(t2.amount, 0)) < 0, 'Yes', 'No') AS credit_limit_breached
FROM Users u
    LEFT JOIN (SELECT paid_by, SUM(amount) as amount FROM Transactions GROUP BY 1) t1 
        ON u.user_id = t1.paid_by
    LEFT JOIN (SELECT paid_to, SUM(amount) as amount FROM Transactions GROUP BY 1) t2 
        ON u.user_id = t2.paid_to
GROUP BY user_id, user_name, credit
;

# Another solution (Better)
-- for each user -> total amount that user has paid to other
--              -> total amount that user has got from others
-- credit - (1) + (2) -> credit limit +, no ; -,yes

SELECT
    user_id,
    user_name,
    credit - SUM(IF(u.user_id = t.paid_by, t.amount, 0)) + SUM(IF(u.user_id = t.paid_to, t.amount, 0)) credit,
    IF(credit - SUM(IF(u.user_id = t.paid_by, t.amount, 0)) + SUM(IF(u.user_id = t.paid_to, t.amount, 0)) < 0, 'Yes', 'No') credit_limit_breached
FROM Users u LEFT JOIN Transactions t ON u.user_id = t.paid_by or u.user_id = t.paid_to
GROUP BY 1, 2

