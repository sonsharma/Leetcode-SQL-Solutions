# https://leetcode.com/problems/unpopular-books/

-- for all books - qty sold in last year
-- filter out from (1) - all books which are avail for less than 1 month

SELECT 
    b.book_id, name
FROM Books b LEFT JOIN Orders o on b.book_id = o.book_id AND o.dispatch_date >= '2018-06-23'
WHERE b.available_from < '2019-05-23' 
GROUP BY b.book_id, name
HAVING coalesce(sum(quantity),0) < 10 
;