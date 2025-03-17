
SELECT 
g.id AS guard_number,
g.code_name AS code_name,
g.status AS rank,
r.last_check_time AS last_seen_in_room,
c.movement_detected_time AS spotted_outside_time,
c.location AS spotted_outside_location,
c.movement_detected_time - r.last_check_time AS time_between_room_and_outside,
(SELECT MAX(c2.movement_detected_time) - MIN(c2.movement_detected_time)
    FROM camera c2
    WHERE c2.guard_spotted_id IS NOT NULL) AS time_range
FROM guard g
JOIN room r ON g.assigned_room_id = r.id
LEFT JOIN camera c ON g.id = c.guard_spotted_id
WHERE r.isVacant = TRUE 
AND c.movement_detected = TRUE
ORDER BY g.id;
            
