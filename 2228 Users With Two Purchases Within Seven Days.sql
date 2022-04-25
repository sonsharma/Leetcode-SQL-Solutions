-- https://leetcode.com/submissions/detail/687024936/

SELECT
    DISTINCT p1.user_id
FROM purchases p1 JOIN purchases p2 
    ON p1.user_id = p2.user_id AND p1.purchase_id <> p2.purchase_id 
    AND ABS(DATEDIFF(p1.purchase_date, p2.purchase_date)) <= 7
ORDER BY 1

-- Another Solution
select  distinct user_id
from (select user_id, purchase_date,
lag(purchase_date) over (partition by user_id order by purchase_date) prev_purchase_date
from purchases) t
where datediff(purchase_date, prev_purchase_date) <=7