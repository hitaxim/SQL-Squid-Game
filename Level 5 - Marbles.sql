WITH most_frequent_interaction AS (
    SELECT
        CASE
            WHEN player1_id = 456 THEN player2_id
            ELSE player1_id
        END AS other_player_id,
        COUNT(*) as interaction_count
    FROM daily_interactions
    WHERE player1_id = 456 OR player2_id = 456
    GROUP BY 
        CASE
            WHEN player1_id = 456 THEN player2_id
            ELSE player1_id
        END
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
SELECT
    p1.first_name AS player1_name,
    p2.first_name AS player2_name,
    mfi.interaction_count
FROM most_frequent_interaction mfi
JOIN player p1 ON p1.id = 456
JOIN player p2 ON p2.id = mfi.other_player_id
WHERE EXISTS (
    SELECT 1 
    FROM daily_interactions di
    WHERE ((di.player1_id = 456 AND di.player2_id = mfi.other_player_id)
    OR (di.player1_id = mfi.other_player_id AND di.player2_id = 456))
);
        
