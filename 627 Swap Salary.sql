-- https://leetcode.com/problems/swap-salary/

UPDATE salary 
SET sex = case when sex = 'f' then 'm' else 'f' end;

-- Another solution
UPDATE Salary
SET sex = IF(sex='f', 'm', 'f')