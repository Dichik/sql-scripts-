SELECT *
FROM payment_orders
WHERE sum IN ((SELECT MIN(estimate.sum) FROM estimate), (SELECT MAX(estimate.sum) FROM estimate));
