
WITH MostFailedGameType AS (
    SELECT e.game_type
    FROM equipment e
    JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
    GROUP BY e.game_type
    ORDER BY COUNT(*) DESC
    LIMIT 1
),
WorstSupplier AS (
    SELECT e.supplier_id
    FROM equipment e
    JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
    WHERE e.game_type = (SELECT game_type FROM MostFailedGameType)
    GROUP BY e.supplier_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
),
FirstFailures AS (
    SELECT e.id, MIN(fi.failure_date) as first_failure_date
    FROM equipment e
    JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
    GROUP BY e.id
)
SELECT 
    FLOOR(AVG((ff.first_failure_date - e.installation_date) / 365.2425)) AS avg_lifespan_years
FROM equipment e
JOIN FirstFailures ff ON e.id = ff.id
WHERE e.supplier_id = (SELECT supplier_id FROM WorstSupplier);
         
