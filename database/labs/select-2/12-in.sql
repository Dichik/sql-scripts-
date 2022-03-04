SELECT *
FROM estimate
WHERE sum IN
      ((SELECT COUNT(*) FROM payment_orders WHERE payment_orders.sum > 100),
       (SELECT MIN(payment_orders.sum) FROM payment_orders));
