DELIMITER //
CREATE PROCEDURE getTen(str TEXT)
BEGIN
    SET @i = 0;
    SET @str = str;
    WHILE (@i < 10)
        DO
            SET @str = CONCAT(@str, str);
            SET @i = @i+1;
        END WHILE;
    SELECT @str;
END //
CALL getTen('SO');