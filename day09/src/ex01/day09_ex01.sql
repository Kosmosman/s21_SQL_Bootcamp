CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER AS $person_audit$
	BEGIN
		INSERT INTO person_audit(type_event, row_id, name, age, gender, address)
		SELECT 'U' AS type_event, OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address FROM person LIMIT 1;
		RETURN NULL;
	END;
$person_audit$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_person_update_audit
	AFTER UPDATE ON person
	FOR EACH ROW
	EXECUTE FUNCTION fnc_trg_person_update_audit();
	
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT * FROM person_audit