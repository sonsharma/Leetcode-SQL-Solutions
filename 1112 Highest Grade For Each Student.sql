# https://leetcode.com/problems/highest-grade-for-each-student/submissions/

SELECT 
    student_id,
    course_id,
    grade
FROM (SELECT
    *,
    RANK() OVER (Partition by student_id ORDER BY grade desc, course_id) as row_rank
FROM Enrollments) e
WHERE row_rank = 1