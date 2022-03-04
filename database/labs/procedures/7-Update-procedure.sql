DELIMITER //
CREATE PROCEDURE doubleEstimateSums()
BEGIN
    UPDATE estimate SET sum = sum*2;
END //
CALL doubleEstimateSums();