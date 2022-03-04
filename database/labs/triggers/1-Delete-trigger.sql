CREATE TRIGGER on_delete
    BEFORE DELETE
    ON estimate
    FOR EACH ROW
    UPDATE estimate
    SET sum = sum + 1;
