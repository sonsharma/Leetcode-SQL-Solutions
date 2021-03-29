# https://leetcode.com/problems/monthly-transactions-ii/

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
       SUM(CASE WHEN state = 'bc' THEN 1 ELSE 0 END) AS chargeback_count,
       SUM(CASE WHEN state = 'bc' THEN amount ELSE 0 END) AS chargeback_amount
FROM
(
    SELECT id, country, 'bc' AS state, amount, c.trans_date
    FROM Transactions t
    RIGHT JOIN Chargebacks c
    ON t.id = c.trans_id
UNION ALL
    SELECT id, country, state, amount, trans_date 
    FROM Transactions
) tem
GROUP BY country, DATE_FORMAT(trans_date, '%Y-%m')
HAVING approved_count + approved_amount + chargeback_count + chargeback_amount <> 0