
SELECT 
    team_id,
    AVG(age) AS avg_team_age,
    CASE 
    WHEN AVG(age) < 40 THEN 'Fit'
    WHEN AVG(age) BETWEEN 40 AND 50 THEN 'Grizzled'
    ELSE 'Elderly'
END AS age_group,
RANK() OVER (ORDER BY AVG(age) DESC) AS age_rank
FROM player
WHERE status = 'alive' 
AND team_id IS NOT NULL
GROUP BY team_id
HAVING COUNT(*) = 10
ORDER BY age_rank;
