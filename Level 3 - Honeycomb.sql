
WITH temperature_extremes AS (
    SELECT month 
    FROM monthly_temperatures 
    WHERE avg_temperature = (SELECT MAX(avg_temperature) FROM monthly_temperatures)
        OR avg_temperature = (SELECT MIN(avg_temperature) FROM monthly_temperatures)
)
SELECT 
    h.shape,
    EXTRACT(MONTH FROM h.date) AS month,
    AVG(h.average_completion_time) AS avg_time
FROM honeycomb_game h
WHERE EXTRACT(MONTH FROM h.date) IN (
    SELECT month FROM temperature_extremes
)
AND h.date >= CURRENT_DATE - INTERVAL '20 years'
GROUP BY h.shape, EXTRACT(MONTH FROM h.date)
ORDER BY avg_time;   
