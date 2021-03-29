# https://leetcode.com/problems/get-highest-answer-rate-question/

select t1.question_id as survey_log from
(select question_id from survey_log where answer_id IS NOT NULL) as t1
GROUP BY t1.question_id
ORDER BY count(t1.question_id) DESC
LIMIT 1;

# Another solution
SELECT
    question_id survey_log
FROM survey_log
GROUP BY 1
ORDER BY SUM(IF(answer_id is not null, 1, 0))/COUNT(IF(action='show',1,0)) desc
LIMIT 1