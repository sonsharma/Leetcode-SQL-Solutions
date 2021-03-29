# https://leetcode.com/problems/evaluate-boolean-expression/

SELECT
    left_operand, 
    operator, 
    right_operand, 
    CASE WHEN operator ='>' then if(v1.value > v2.value, 'true', 'false')
        WHEN operator = '<' then if(v1.value < v2.value, 'true', 'false')
        WHEN operator = '=' then if(v1.value = v2.value, 'true', 'false') END AS value
FROM Expressions e 
    LEFT JOIN Variables v1 ON e.left_operand = v1.name
    LEFT JOIN Variables v2 ON e.right_operand = v2.name
GROUP BY left_operand, operator, right_operand