SELECT *
FROM payment_orders p
         JOIN cece ce on ce.id = p.cece_id
         JOIN companies co on co.id = p.directed_to;