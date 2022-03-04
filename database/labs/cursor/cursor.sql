DELIMITER //
DROP PROCEDURE IF EXISTS cursorPro;
CREATE PROCEDURE cursorPro()
BEGIN
    DECLARE tempSum FLOAT;
    DECLARE stop INT;
    DECLARE cur CURSOR FOR SELECT sum FROM estimate;
    DECLARE EXIT HANDLER FOR NOT FOUND
    SET stop = 5;
    OPEN cur;
    summer:
    LOOP
        FETCH cur INTO tempSum;
        IF tempSum > 500 THEN
            UPDATE estimate SET sum = sum - 100 WHERE sum > 100;
        ELSE
            UPDATE estimate SET sum = sum * 2 WHERE sum < 500;
        END IF;
        SET stop = stop - 1;
        IF stop = 0 THEN
            LEAVE summer;
        END IF;
    END LOOP;
    CLOSE cur;
END //
CALL cursorPro();