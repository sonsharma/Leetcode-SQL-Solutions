#https://leetcode.com/problems/bank-account-summary-ii/

SELECT
    name,
    IFNULL(SUM(amount), 0) balance
FROM Users u LEFT JOIN Transactions t USING(account)
GROUP BY u.account
HAVING balance > 10000