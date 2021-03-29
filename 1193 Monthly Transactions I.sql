# https://leetcode.com/problems/monthly-transactions-i/

SELECT
    DATE_FORMAT(trans_date, '%Y-%m') as month, 
    country,
    COUNT(DISTINCT id) AS trans_count,
    SUM(IF(state = 'approved', 1, 0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country


