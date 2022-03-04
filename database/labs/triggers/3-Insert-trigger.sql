CREATE TRIGGER on_insert
    BEFORE UPDATE
    ON estimate
    FOR EACH ROW
    INSERT estimate
    SET naming = CONCAT('!',naming);
