SELECT 
    flight_id,
    flight_date,
    airline_id,
    origin_airport_id,
    destination_airport_id,
    scheduled_departure,
    actual_departure,
    dep_delay_new,
    cancelled,
    CASE
        WHEN dep_delay_new > 0 THEN 1
        ELSE 0
    END AS is_delayed
FROM
    flight
WHERE
    cancelled = 0
;