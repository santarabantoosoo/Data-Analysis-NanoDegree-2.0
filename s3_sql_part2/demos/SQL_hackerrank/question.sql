-- https://www.hackerrank.com/challenges/challenges/problem 


-- A solution with correlated subquery

 select a.hacker_id,a.name,count(b.hacker_id)    
    from Hackers a, Challenges b
    WHERE a.hacker_id = b.hacker_id
    GROUP BY a.hacker_id,a.name
    HAVING count(b.hacker_id) not in (select distinct count(hacker_id) from Challenges
    WHERE hacker_id <> a.hacker_id
    group by hacker_id
    having count(hacker_id) < (select max(x.challenge_count) 
    from (select count(b.challenge_id) as challenge_count from Challenges b GROUP BY b.hacker_id) as x ))
    ORDER BY count(b.hacker_id) desc, a.hacker_id 


-- hacker_rank solution

--  **************************      USE MSSQL ******************************* 

WITH data
AS
(
SELECT c.hacker_id id, h.name name, count(c.hacker_id) counter
FROM Hackers h
JOIN Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
)
/* select records from above */
SELECT id,name,counter
FROM data
WHERE
counter=(SELECT max(counter) FROM data) /*select user that has max count submission*/
OR
counter in (SELECT counter FROM data
GROUP BY counter
HAVING count(counter)=1 ) /*filter out the submission count which is unique*/
ORDER BY counter desc, id 



-- my solution  not working 

WITH chal AS(
select hacker_id, name, COUNT(challenge_id) no_chal
from challenges c 
JOIN hackers h
USING (hacker_id)
group by 1,2
-- ORDER BY 3 desc, 1  we can't use order by here as this is a temp table not the result table 
),

no_rep AS( 
SELECT no_chal, COUNT(no_chal) rep_no
FROM chal
GROUP BY no_chal
HAVING rep_no = 1)

SELECT hacker_id, name, no_chal
FROM chal
JOIN no_rep
USING(no_chal)
WHERE no_chal = (SELECT MAX(no_chal) FROM chal)



-- # solution EXPALANATION 

-- ALL Hackerrank SQL Solutions in ONE Video! | Easy Medium Hard Problems - YouTube
-- https://www.youtube.com/watch?v=vpzO8QTrgbc 

-- 03:48:14 Challenges (Medium) 
 
