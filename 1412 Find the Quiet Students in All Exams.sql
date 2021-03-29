# https://leetcode.com/problems/find-the-quiet-students-in-all-exams/

-- Find out max, min score for each exam (exam)
-- Find out student id who have max, min score
-- Find all student who gave exams minus (2)
-- Find name of students from 3

WITH CTE AS (SELECT student_id,
                RANK() OVER (PARTITION BY exam_id ORDER BY score desc) as not_quiet
            FROM Exam
            UNION
            SELECT student_id,
                RANK() OVER (PARTITION BY exam_id ORDER BY score) as not_quiet
            FROM Exam)
        
SELECT DISTINCT e.student_id as student_id, s.student_name
FROM Exam e LEFT JOIN Student s USING (student_id)
WHERE e.student_id NOT IN (SELECT student_id FROM CTE WHERE not_quiet = 1)
ORDER BY e.student_id
;

# Another solution
-- Rank students in each exam by score desc
-- Rank students in each exam by score asc
-- filter students whose rank in 1,2 is not 1 -> means students'marks is neither lowest not highest
-- get names of 3 from student and order by student id

WITH CTE AS (SELECT
            exam_id,
            student_id,
            DENSE_RANK() OVER (PARTITION BY exam_id ORDER BY Score desc) desc_rank,
            DENSE_RANK() OVER (PARTITION BY exam_id ORDER BY Score) asc_rank
        FROM Exam)

SELECT
    s.student_id,
    s.student_name
FROM Student s 
WHERE s.student_id NOT IN (SELECT student_id 
                           FROM CTE 
                           WHERE desc_rank = 1 or asc_rank = 1)
and s.student_id IN (SELECT DISTINCT student_id FROM CTE)
GROUP BY 1
ORDER BY student_id