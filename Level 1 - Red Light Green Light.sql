SELECT * 
FROM player
WHERE status = 'alive' AND debt > 400000000 AND 
(age > 65 OR (vice = 'Gambling' AND has_close_family = False));
