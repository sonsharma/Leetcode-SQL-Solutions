# https://leetcode.com/problems/market-analysis-ii/
-- Rank rows based on order_date and seller_id
-- Item_id of favorite brand for each user
-- merge 1, 2 for the result


WITH Orders_rank as (SELECT
    item_brand,
    seller_id,
    rank() OVER (Partition by seller_id ORDER BY order_date) as row_rank
FROM Orders o LEFT JOIN Items i ON o.item_id = i.item_id)

SELECT
    u.user_id as seller_id,
    COALESCE(IF(u.favorite_brand = o.item_brand, 'yes', 'no'), 'no') as 2nd_item_fav_brand
FROM Users u LEFT JOIN Orders_rank o ON u.user_id = o.seller_id and row_rank = 2
;


