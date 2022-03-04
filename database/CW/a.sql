SELECT d.name, d.surname, COUNT(t.bus) AS trips
FROM trip t
         JOIN buses b ON b.id = t.bus
         JOIN drivers d ON d.id = b.driver
WHERE b.can_be_used = false
GROUP BY d.name, d.surname
ORDER BY trips DESC;