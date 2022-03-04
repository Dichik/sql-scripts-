SELECT MAX(sum) AS max_sum
FROM payment_orders
HAVING max_sum > 100