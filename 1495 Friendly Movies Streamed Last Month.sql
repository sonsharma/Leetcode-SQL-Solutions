-- https://leetcode.com/problems/friendly-movies-streamed-last-month/

SELECT
    DISTINCT title
FROM TVProgram tv LEFT JOIN Content c USING(content_id)
WHERE DATE_FORMAT(program_date, '%Y-%m') = '2020-06' and Kids_content = 'Y' and content_type = 'movies'