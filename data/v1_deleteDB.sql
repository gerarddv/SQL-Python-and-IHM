-- TODO 1.3a : Détruire les tables manquantes et modifier celles ci-dessous
DROP VIEW IF EXISTS LesAgesSportifs;
DROP VIEW IF EXISTS LesNbsEquipiers;
DROP TABLE IF EXISTS LesEpreuves;
DROP TABLE IF EXISTS LesSportifs;
DROP TABLE IF EXISTS LesParticipants;
DROP TABLE IF EXISTS LesEquipes;
DROP TABLE IF EXISTS LesEquipiers;
DROP TABLE IF EXISTS LesParticipants;
DROP TABLE IF EXISTS LesResultats;
-- TODO 3.3 : pensez à détruire vos triggers !
DROP TRIGGER IF EXISTS DisjointEquipesInsert1;
DROP TRIGGER IF EXISTS DisjointEquipesInsert2;
DROP TRIGGER IF EXISTS DisjointSportifsInsert1;
DROP TRIGGER IF EXISTS DisjointSportifsInsert2;

DROP TRIGGER IF EXISTS DisjointEquipesUpdate1;
DROP TRIGGER IF EXISTS DisjointEquipesUpdate2;
DROP TRIGGER IF EXISTS DisjointSportifsUpdate1;
DROP TRIGGER IF EXISTS DisjointSportifsUpdate2;
DROP TRIGGER IF EXISTS DisjointEquipesDelete;
DROP TRIGGER IF EXISTS DisjointSportifsDelete;

DROP TRIGGER IF EXISTS DisjointParticpantsDelete1;
DROP TRIGGER IF EXISTS DisjointParticpantsDelete2;