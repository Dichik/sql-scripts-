DELIMITER //
CREATE PROCEDURE printExact(str TEXT)
BEGIN
    SELECT str;
END //
CALL printExact('Hello with argument');