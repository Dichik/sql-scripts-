CREATE TRIGGER on_update
    BEFORE UPDATE
    ON estimate
    FOR EACH ROW
    UPDATE estimate
    SET naming = CONCAT(naming,'!');
