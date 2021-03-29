# https://leetcode.com/problems/tree-node/

SELECT
    id,
    CASE WHEN p_id is null THEN 'Root'
        WHEN id not in (SELECT DISTINCT p_id FROM tree) THEN 'Leaf'
        ELSE 'Inner'
    END as Type
FROM tree