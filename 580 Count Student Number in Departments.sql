# https://leetcode.com/problems/count-student-number-in-departments/

SELECT d.dept_name, COUNT(s.student_id) AS student_number
FROM student s RIGHT JOIN department d ON s.dept_id = d.dept_id
GROUP BY d.dept_name 
ORDER BY student_number DESC, d.dept_name;