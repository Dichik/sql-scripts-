DELIMITER //
CREATE FUNCTION printDouble(str TEXT) RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE tempString TEXT;
    SET tempString = CONCAT(str, str);
    RETURN tempString;
END //
SELECT printDouble('Hello with argument');
