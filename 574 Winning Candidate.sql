# https://leetcode.com/problems/winning-candidate/

SELECT Name FROM Candidate
WHERE id = (SELECT
    CandidateId
FROM Vote
GROUP BY CandidateId
ORDER BY COUNT(*) desc
LIMIT 1)