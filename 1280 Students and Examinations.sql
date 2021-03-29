# https://leetcode.com/problems/students-and-examinations/

SELECT
    st.student_id,
    st.student_name,
    sb.subject_name,
    COUNT(e.student_id) attended_exams
FROM Students st
    JOIN Subjects sb
    LEFT JOIN Examinations e ON st.student_id = e.student_id and sb.subject_name = e.subject_name
GROUP BY 1, 2, 3
ORDER BY 1, 3