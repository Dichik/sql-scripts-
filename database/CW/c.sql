SELECT type, COUNT(type)
FROM trip_types
         JOIN trip t on trip_types.id = t.trip_type
GROUP BY type
ORDER BY COUNT(t.trip_type) DESC LIMIT 1