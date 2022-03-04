CREATE VIEW payment_treasury_companies AS
SELECT payment_orders.id,
       payment_orders.cece_id,
       payment_orders.sum,
       t.naming AS treasury,
       c.naming AS company,
       created_at
FROM payment_orders
         JOIN treasury t on payment_orders.directed_to = t.id
         JOIN companies c on c.id = payment_orders.created_by;