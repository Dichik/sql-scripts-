SELECT cece_id, SUM(sum) AS total_sum
FROM payment_orders
GROUP BY cece_id
HAVING total_sum > 200