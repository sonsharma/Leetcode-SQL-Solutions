# https://leetcode.com/problems/biggest-single-number/

SELECT max(num) as num from (SELECT
        num
    FROM
        my_numbers
    GROUP by num
    HAVING count(*) = 1
)h;