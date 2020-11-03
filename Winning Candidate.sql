SELECT C.Name FROM Candidate C
WHERE id = (SELECT CandidateId FROM Vote GROUP BY CandidateId ORDER BY COUNT(id) DESC LIMIT 1);
