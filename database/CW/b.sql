SELECT MONTH(trip_date) AS 'month', SUM(price) AS income
FROM trip
         JOIN trip_types tt ON trip.trip_type = tt.id
group by month
