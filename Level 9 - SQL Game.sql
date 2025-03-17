
WITH disappearance_window AS (
    SELECT date, start_time, end_time
    FROM game_schedule
    WHERE type = 'Squid Game'
    ORDER BY date DESC
    LIMIT 1
),
guards_away AS (
    SELECT g.id AS guard_id, g.assigned_post, g.shift_start, g.shift_end, dal.door_location, dal.access_time
    FROM guard g
    JOIN disappearance_window dw
    ON g.shift_start < dw.end_time AND g.shift_end > dw.start_time
    LEFT JOIN daily_door_access_logs dal
    ON dal.guard_id = g.id
    AND dal.access_time BETWEEN g.shift_start AND g.shift_end
    WHERE g.assigned_post != dal.door_location
),
suspicious_access AS (
    SELECT
        g.id AS potential_associate_id,
        dal.access_time AS time_accessed
    FROM daily_door_access_logs dal
    JOIN guard g ON g.id = dal.guard_id
    WHERE dal.door_location = 'Upper Management'
    AND dal.access_time BETWEEN '11:00:00'::time AND '12:00:00'::time
    AND g.id != 31
)
SELECT * FROM suspicious_access;
