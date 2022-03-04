CREATE VIEW payment_treasury_companies_cece AS
SELECT c.naming AS cece_name,
       sum,
       treasury,
       company,
       created_at,
       naming
FROM payment_treasury_companies
         JOIN cece c on c.id = payment_treasury_companies.cece_id