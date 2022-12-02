
CREATE TRIGGER IF NOT EXISTS DisjointEquipesInsert1
    BEFORE INSERT
    ON LesEquipes
    WHEN NEW.numEq NOT IN(SELECT numSp FROM LesSportifs)
BEGIN
    INSERT INTO LesParticipants (numP,numEp) VALUES (NEW.numEq,NULL);
END/

CREATE TRIGGER IF NOT EXISTS DisjointEquipesInsert2
    BEFORE INSERT
    ON LesEquipes
    WHEN NEW.numEq IN(SELECT numSp FROM LesSportifs)
BEGIN
    SELECT RAISE(ABORT,'Equipes ID not disjointed');
END/


CREATE TRIGGER IF NOT EXISTS DisjointSportifsInsert1
    BEFORE INSERT
    ON LesSportifs
    WHEN NEW.numSp NOT IN(SELECT numEq FROM LesEquipes)
BEGIN
    INSERT INTO LesParticipants (numP,numEp) VALUES (NEW.numSp,NULL);
END/

CREATE TRIGGER IF NOT EXISTS DisjointSportifsInsert2
    BEFORE INSERT
    ON LesSportifs
    WHEN NEW.numSp IN(SELECT numEq FROM LesEquipes)
BEGIN
    SELECT RAISE(ABORT,'Sportifs ID not disjointed');
END/

CREATE TRIGGER IF NOT EXISTS DisjointEquipesUpdate1
    BEFORE UPDATE
    ON LesEquipes
    FOR EACH ROW WHEN NEW.numEq NOT IN(SELECT numSp FROM LesSportifs)
BEGIN
    UPDATE LesParticipants SET numP = NEW.numEq WHERE numP == OLD.numEq;
END/

CREATE TRIGGER IF NOT EXISTS DisjointEquipesUpdate2
    BEFORE UPDATE
    ON LesEquipes
    FOR EACH ROW WHEN NEW.numEq IN(SELECT numSp FROM LesSportifs)
BEGIN
    SELECT RAISE(ABORT,'Equipes ID not disjointed');
END/


CREATE TRIGGER IF NOT EXISTS DisjointSportifsUpdate1
    BEFORE UPDATE
    ON LesSportifs
    WHEN NEW.numSp NOT IN(SELECT numEq FROM LesEquipes)
BEGIN
    UPDATE LesParticipants SET numP = NEW.numSp WHERE numP == OLD.numSp;
END/

CREATE TRIGGER IF NOT EXISTS DisjointSportifsUpdate2
    BEFORE UPDATE
    ON LesSportifs
    WHEN NEW.numSp IN(SELECT numEq FROM LesEquipes)
BEGIN
    SELECT RAISE(ABORT,'Sportifs ID not disjointed');
END/

CREATE TRIGGER IF NOT EXISTS DisjointEquipesDelete
    BEFORE DELETE
    ON LesEquipes
    FOR EACH ROW WHEN NEW.numEq IN(SELECT numSp FROM LesParticipants)
BEGIN
    DELETE FROM LesParticipants WHERE numP == OLD.numEq;
END/

CREATE TRIGGER IF NOT EXISTS DisjointSportifsDelete
    BEFORE DELETE
    ON LesEquipes
    FOR EACH ROW WHEN NEW.numSp IN(SELECT numSp FROM LesParticipants)
BEGIN
    DELETE FROM LesParticipants WHERE numP == OLD.numSp;
END;