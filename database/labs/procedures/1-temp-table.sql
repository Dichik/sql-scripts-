CREATE TEMPORARY TABLE temp_table
	SELECT
		*
	FROM companies;
SELECT * FROM temp_table;