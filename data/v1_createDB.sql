-- TODO 1.3a : Créer les tables manquantes et modifier celles ci-dessous
CREATE TABLE IF NOT EXISTS LesSportifs
(
  numSp NUMBER(4),
  nomSp VARCHAR2(20),
  prenomSp VARCHAR2(20),
  pays VARCHAR2(20),
  categorieSp VARCHAR2(10),
  dateNaisSp DATE,
  CONSTRAINT SP_CK1 CHECK(numSp > 0),
  CONSTRAINT SP_CK2 CHECK(categorieSp IN ('feminin','masculin'))
);

CREATE TABLE IF NOT EXISTS LesEpreuves
(
  numEp NUMBER(3),
  nomEp VARCHAR2(20),
  formeEp VARCHAR2(13),
  nomDi VARCHAR2(25),
  categorieEp VARCHAR2(10),
  nbSportifsEp NUMBER(2),
  dateEp DATE,
  CONSTRAINT EP_PK PRIMARY KEY (numEp),
  CONSTRAINT EP_CK1 CHECK (formeEp IN ('individuelle','par equipe','par couple')),
  CONSTRAINT EP_CK2 CHECK (categorieEp IN ('feminin','masculin','mixte')),
  CONSTRAINT EP_CK3 CHECK (numEp > 0),
  CONSTRAINT EP_CK4 CHECK (nbSportifsEp > 0)
);

CREATE TABLE IF NOT EXISTS LesEquipes
(
	numEq NUMBER(4) PRIMARY KEY NOT NULL,
	nbSportifsEq NUMBER(3),
	CONSTRAINT SP_CK3 CHECK(numEq > 0)
);

CREATE TABLE IF NOT EXISTS LesEquipiers
(
	numEq NUMBER(4) NOT NULL,
	numSp NUMBER(4) NOT NULL,
	PRIMARY KEY(numEq, numSP),
	FOREIGN KEY(numEq) REFERENCES LesEquipes(numEq),
	FOREIGN KEY(numSp) REFERENCES LesSportifs(numSp)
);

CREATE TABLE IF NOT EXISTS LesParticipants
(
	numP NUMBER(4) PRIMARY KEY,
	numEp NUMBER(3),
	FOREIGN KEY(numP) REFERENCES LesEquipes(numEq),
	FOREIGN KEY(numP) REFERENCES LesSportifs(numSp)
);

CREATE TABLE IF NOT EXISTS LesResultats
(
	numEp NUMBER(3) PRIMARY KEY,
	md_gold NUMBER(4),
	md_silver NUMBER(4),
	md_bronze NUMBER(4),
	CONSTRAINT RE_CK1 CHECK (gold>0),
	CONSTRAINT RE_CK2 CHECK (silver>0),
	CONSTRAINT RE_CK3 CHECK (bronze> 0)
);

-- TODO 1.4a : ajouter la définition de la vue LesAgesSportifs
CREATE VIEW IF NOT EXISTS LesAgesSportifs AS
	SELECT numSp, nomSp, prenomSp, pays, categorieSp, dateNaisSp, DATEDIFF(year, dateNaisSp, CURRENT_DATE)
	FROM LesSportifs;

-- TODO 1.5a : ajouter la définition de la vue LesNbsEquipiers
CREATE VIEW IF NOT EXISTS LesNbsEquipiers AS
	SELECT numEq, COUNT(numSp)
	FROM LesEquipiers
	GROUP BY numEq;
-- TODO 3.3 : ajouter les éléments nécessaires pour créer le trigger (attention, syntaxe SQLite différent qu'Oracle)
