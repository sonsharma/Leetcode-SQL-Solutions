# https://leetcode.com/problems/students-with-invalid-departments/
SELECT
    id, name
FROM
    Students s
WHERE department_id not in (SELECT id from departments)
;