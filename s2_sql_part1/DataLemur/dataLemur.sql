-- https://datalemur.com/questions/matching-skills

SELECT a.candidate_id
FROM candidates a
INNER JOIN candidates b 
ON a.candidate_id = b.candidate_id
INNER JOIN candidates c
ON a.candidate_id = c.candidate_id
WHERE a.skill = 'Python' AND b.skill = 'Tableau' AND c.skill = 'PostgreSQL';


