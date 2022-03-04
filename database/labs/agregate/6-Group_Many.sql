SELECT co.naming,ce.naming, SUM(sum)
FROM estimate
         JOIN cece ce ON ce.id = estimate.cece_id
         JOIN companies co on co.id = estimate.company_id
GROUP BY co.naming, ce.naming