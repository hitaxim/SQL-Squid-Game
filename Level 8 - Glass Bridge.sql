
WITH GameWithHighestAvgHesitation AS (
    SELECT 
        g.id AS game_id,
        g.date,
        AVG(p.last_moved_time_seconds) AS avg_hesitation_time
    FROM glass_bridge g
    JOIN player p ON g.id = p.game_id
    WHERE LOWER(p.death_description) LIKE '%push%'
    GROUP BY g.id, g.date
    ORDER BY avg_hesitation_time DESC
    LIMIT 1
)
SELECT 
    p.id AS player_id,
    p.first_name,
    p.last_name,
    p.last_moved_time_seconds AS hesitation_time
FROM player p
JOIN GameWithHighestAvgHesitation g ON p.game_id = g.game_id
WHERE LOWER(p.death_description) LIKE '%push%'
ORDER BY p.last_moved_time_seconds DESC
LIMIT 1;
          
