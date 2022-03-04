SELECT o.name, SUM(trip.price * bm.seats  - trip.prepaid_expense)
FROM trip
         JOIN organization o on trip.organization = o.id
         JOIN buses b on b.id = trip.bus
         JOIN bus_models bm on bm.id = b.bus_model
GROUP BY organization
#Кількість людей * Ціну перевезення - Сума авансу