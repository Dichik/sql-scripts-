SELECT name, surname, COUNT(t.bus) AS trips
FROM drivers
         JOIN buses b on drivers.id = b.driver
         JOIN trip t on b.id = t.bus
GROUP BY name, surname
ORDER BY trips DESC LIMIT 1