DELIMITER //
CREATE PROCEDURE treasuries()
BEGIN
    SELECT * FROM treasury;
END //
CALL treasuries();