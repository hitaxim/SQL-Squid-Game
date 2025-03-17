SELECT 
	FLOOR(COUNT(*) * 0.90) AS "Needed Rations", 
	FLOOR(COUNT(*) * 0.90) <= (SELECT amount FROM rations) AS "Sufficient"
FROM player
WHERE status = 'alive' AND IsInsider = False;
                
             
