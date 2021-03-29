# https://leetcode.com/problems/delete-duplicate-emails/

-- APPLY DELETE FUNCTION
-- CALCULATE UNIQUE EMAILS -> CORRESPONDING MIN ID
-- FILTER FROM THE ORIGINAL TABLE

DELETE FROM PERSON
WHERE ID NOT IN (SELECT ID 
                 FROM (SELECT MIN(ID) AS ID 
                       FROM PERSON 
                       GROUP BY EMAIL) P
                )
;

# Another Solution
DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id