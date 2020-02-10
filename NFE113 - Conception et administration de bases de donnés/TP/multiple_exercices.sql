
DROP TABLE If EXISTS ABONNEMENT;
DROP TABLE If EXISTS BIBLIOTHEQUE;
DROP TABLE If EXISTS EMPRUNT;
DROP TABLE If EXISTS EXEMPLAIRE;
DROP TABLE If EXISTS CARACTERISATION;
DROP TABLE If EXISTS MOT_CLEF;
DROP TABLE If EXISTS LIVRETRADUIT;
DROP TABLE If EXISTS LIVREORIGINAL;
DROP TABLE If EXISTS LIVRE;
DROP TABLE If EXISTS DOMICILIATION;
DROP TABLE If EXISTS VILLE;
DROP TABLE If EXISTS ABONNE;
DROP TABLE If EXISTS HABITANT;
DROP TABLE If EXISTS PERSONNEPHYSIQUE;
DROP FUNCTION If EXISTS UNIQUE_ID();
DROP TRIGGER If EXISTS HABITANT_TG ON HABITANT;
DROP TRIGGER If EXISTS ABONNE_TG ON ABONNE;








/* Hiérarchie Personne Physique *****************************************************************************/
CREATE TABLE PERSONNEPHYSIQUE(
	IDPERSONNEPHYSIQUE SERIAL,
	NOM VARCHAR(20) NOT NULL,
	PRENOM VARCHAR(20),
	AGE INTEGER,
	CONSTRAINT PERSONNEPHYSIQUE_PK PRIMARY KEY (IDPERSONNEPHYSIQUE),
	CONSTRAINT AGE_DK CHECK (AGE BETWEEN 0 AND 120)
);





CREATE TABLE HABITANT(
) INHERITS(PERSONNEPHYSIQUE);





CREATE TABLE ABONNE(
) INHERITS(HABITANT);
/* Hiérarchie Personne Physique *****************************************************************************/










/* Ville ****************************************************************************************************/
CREATE TABLE VILLE(
	IDVILLE SERIAL,
	NOM VARCHAR(20) NOT NULL,
	CONSTRAINT VILLE_PK PRIMARY KEY (IDVILLE)
);





CREATE TABLE DOMICILIATION(
	IDVILLE INTEGER,
	IDPERSONNEPHYSIQUE INTEGER,
	CONSTRAINT DOMICILIATION_PK PRIMARY KEY (IDVILLE, IDPERSONNEPHYSIQUE),
	CONSTRAINT DOMICILIATIONTOVILLE_FK FOREIGN KEY (IDVILLE) REFERENCES VILLE(IDVILLE)
--	Remplacer cette contrainte par un trigger
--	CONSTRAINT DOMICILIATIONTOHABITANT_FK FOREIGN KEY (IDPERSONNEPHYSIQUE) REFERENCES HABITANT(IDPERSONNEPHYSIQUE)
);
/* Ville ****************************************************************************************************/










/* Hiérarchie Livre *****************************************************************************************/
CREATE TABLE LIVRE(
	IDLIVRE SERIAL,
	ISBN VARCHAR(20),
	TITRE VARCHAR(50) NOT NULL,
	LANGUE VARCHAR(15) CHECK (LANGUE IN ('FR', 'BR', 'SP')),
	CONSTRAINT LIVRE_PK PRIMARY KEY (IDLIVRE)
);





CREATE TABLE LIVREORIGINAL(
	SIECLE INTEGER CHECK (SIECLE BETWEEN 0 AND 21),
	CATEGORIE VARCHAR(20)
) INHERITS(LIVRE);





CREATE TABLE LIVRETRADUIT(
	IDLIVREORIGINAL INTEGER
) INHERITS(LIVRE);





CREATE OR REPLACE FUNCTION "mir_livreTableAbstraite"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RAISE EXCEPTION 'La table LIVRE est un concept abstrait et, à ce titre, on ne peut pas insérer des valeurs';
END
$BODY$;


CREATE TRIGGER "check_livreTableAbstraite"
	BEFORE INSERT ON livre
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_livreTableAbstraite"();
/* Hiérarchie Livre *****************************************************************************************/










/* Mot clé **************************************************************************************************/
CREATE TABLE MOT_CLEF (
	IDMOT SERIAL,
	MOT VARCHAR(20),
	CONSTRAINT MOT_CLEF_PK PRIMARY KEY (IDMOT)
);





CREATE TABLE CARACTERISATION(
	IDLIVRE INTEGER,
	IDMOT INTEGER,
	CONSTRAINT CARACT_PK PRIMARY KEY (IDLIVRE, IDMOT),
--	Remplacer cette contrainte par un trigger
--	CONSTRAINT CARACTTOLIVRE_FK FOREIGN KEY (IDLIVRE) REFERENCES LIVRE(IDLIVRE),
	CONSTRAINT CARACTTOMOT_CLEF_FK FOREIGN KEY (IDMOT) REFERENCES MOT_CLEF(IDMOT)
);
/* Mot clé **************************************************************************************************/










/* Exemplaire ***********************************************************************************************/
CREATE TABLE EXEMPLAIRE(
	IDEXEMPLAIRE SERIAL,
	NUMERO INTEGER,
	DATE_ACHAT DATE,
	PRIX REAL,
	CODE_PRET VARCHAR(20),
	ETAT VARCHAR(15) CHECK (ETAT IN ('BON', 'ABIME', 'EN_REPARATION')),
	IDLIVRE INTEGER,
	CONSTRAINT EXEMPLAIRE_PK PRIMARY KEY (IDEXEMPLAIRE),
--	Remplacer cette contrainte par un trigger
--	CONSTRAINT EXEMPLAIRETOLIVRE_FK FOREIGN KEY (IDLIVRE) REFERENCES LIVRE(IDLIVRE),
	CONSTRAINT CODE_PRET_DK CHECK (CODE_PRET IN ('EXCLU', 'EMPRUNTABLE', 'CONSULTABLE')) 
);





CREATE TABLE EMPRUNT(
	IDPERSONNEPHYSIQUE INTEGER,
	IDEXEMPLAIRE INTEGER,
	DATE_EMPRUNT DATE,
	DATE_RETOUR DATE,
	DATE_RETOUR_REEL DATE,
	NB_RELANCE INTEGER CHECK (NB_RELANCE IN (1, 2, 3)),
	CONSTRAINT EMPRUNT_PK PRIMARY KEY (IDPERSONNEPHYSIQUE, IDEXEMPLAIRE, DATE_EMPRUNT),
--	Remplacer cette contrainte par un trigger
--	CONSTRAINT EMPRUNTTOABONNE_FK FOREIGN KEY (IDPERSONNEPHYSIQUE) REFERENCES ABONNE(IDPERSONNEPHYSIQUE),
	CONSTRAINT EMPRUNTTOEXEMPLAIRE_FK FOREIGN KEY (IDEXEMPLAIRE) REFERENCES EXEMPLAIRE(IDEXEMPLAIRE)
);
/* Exemplaire ***********************************************************************************************/










/* Bibliothéque *********************************************************************************************/
CREATE TABLE BIBLIOTHEQUE(
	IDBIBLIOTHEQUE SERIAL,
	NOM VARCHAR(20) NOT NULL,
	CONSTRAINT BIBLIOTHEQUE_PK PRIMARY KEY (IDBIBLIOTHEQUE)
);





CREATE TABLE ABONNEMENT(
	IDPERSONNEPHYSIQUE INTEGER,
	IDBIBLIOTHEQUE INTEGER,
	NUMERO_ABONNE INTEGER,
	TARIF REAL,
	REDUCTION REAL,
	CONSTRAINT ABONNEMENT_PK PRIMARY KEY (IDPERSONNEPHYSIQUE, IDBIBLIOTHEQUE),
--	Remplacer cette contrainte par un trigger
--	CONSTRAINT ABONNEMENTTOABONNE_FK FOREIGN KEY (IDPERSONNEPHYSIQUE) REFERENCES ABONNE(IDPERSONNEPHYSIQUE),
	CONSTRAINT ABONNEMENTTOBIBLIOTHEQUE_FK FOREIGN KEY (IDBIBLIOTHEQUE) REFERENCES BIBLIOTHEQUE(IDBIBLIOTHEQUE)
);
/* Bibliothéque *********************************************************************************************/

/*-----TRIGGER--CLASSE-ABSTRAITE-----*/

CREATE FUNCTION ABSTRACT_LIVRE()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
RAISE EXCEPTION 'Insertion impossible sur la classe abstraite %',TG_TABLE_NAME;
END $$;


CREATE TRIGGER ABSTRACT_TABLE_TG
BEFORE INSERT
ON LIVRE
FOR EACH row
EXECUTE PROCEDURE ABSTRACT_LIVRE();


CREATE FUNCTION UNIQUE_ID()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $BODY$
DECLARE
NB_ID INTEGER;
BEGIN
	SELECT COUNT(IDPERSONNEPHYSIQUE) FROM PERSONNEPHYSIQUE
	WHERE IDPERSONNEPHYSIQUE = NEW.IDPERSONNEPHYSIQUE INTO NB_ID;
	IF(NB_ID > 0)
	THEN RAISE EXCEPTION 'L''id % exsite dans la table %.%',NEW.IDPERSONNEPHYSIQUE, TG_TABLE_SCHEMA, TG_TABLE_NAME;
	END IF;
	RETURN NEW;
END $BODY$;


CREATE TRIGGER HABITANT_TG
BEFORE UPDATE
ON HABITANT
FOR EACH row
EXECUTE PROCEDURE UNIQUE_ID();


CREATE TRIGGER PERSONNEPHYSIQUE_TG
BEFORE UPDATE
ON PERSONNEPHYSIQUE
FOR EACH row
EXECUTE PROCEDURE UNIQUE_ID();

CREATE TRIGGER ABONNE_TG
BEFORE UPDATE
ON ABONNE
FOR EACH row
EXECUTE PROCEDURE UNIQUE_ID();

/* Contrainte de domicialiation (Mème ID pour l'un ou l'autre)*/

/*CREATE FUNCTION DOMI()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $BODY$
DECLARE
NB_ID INTEGER;
BEGIN
	SELECT COUNT(IDPERSONNEPHYSIQUE) FROM HABITANT
	WHERE IDPERSONNEPHYSIQUE = NEW.IDPERSONNEPHYSIQUE INTO NB_ID;
	IF(NB_ID = 0)
	THEN RAISE EXCEPTION 'L''id % exsite dans la table %.%',NEW.IDPERSONNEPHYSIQUE, TG_TABLE_SCHEMA, TG_TABLE_NAME;
	END IF;
	RETURN NEW;
END $BODY$;


CREATE TRIGGER DOMICILIATION_TG
BEFORE UPDATE
ON DOMICILIATION
FOR EACH row
EXECUTE PROCEDURE UNIQUE_ID();/*

/* TP12 UTILISATEUR DROIT EN LECTURE */
CREATE USER READER WITH PASSWORD 'reader';
GRANT USAGE ON SCHEMA PUBLIC TO READER;
GRANT SELECT ON TP01_LIVRE TO READER;

/* UTILISATEUR DROIT EN ECRITURE */
CREATE USER WRITER WITH PASSWORD 'writer';
GRANT USAGE ON SCHEMA PUBLIC TO WRITER;
GRANT UPDATE, DELETE, INSERT ON TP01_LIVRE TO WRITER;

CREATE VIEW DUPONT AS
SELECT NOM, PRENOM
FROM TP01_ABONNE
WHERE NOM = 'DUPONT';
GRANT SELECT ON DUPONT TO READER;

SELECT * FROM DUPONT

SELECT * FROM TP01_LIVRE;
INSERT INTO TP01_LIVRE(ISBN, TITRE, SIECLE, CATEGORIE) VALUES ('6584dsfX', 'Les Bequilles', 18, 'INFORMATIQUE');

/*TP13*/
DROP OWNED BY user_connect;
DROP USER IF EXISTS user_connect;
CREATE USER user_connect WITH PASSWORD 'user_connect';
GRANT USAGE ON SCHEMA PUBLIC TO user_connect;
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO user_connect;

DROP EXTENSION IF EXISTS postgres_fdw CASCADE;
CREATE EXTENSION postgres_fdw;

CREATE SERVER TP01
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (HOST 'localhost', DBNAME 'TP01_Bibliotheque', PORT '5432');

CREATE USER MAPPING FOR eloy
SERVER TP01
OPTIONS (USER 'user_connect', PASSWORD 'user_connect');


IMPORT FOREIGN SCHEMA PUBLIC
FROM SERVER TP01
INTO tmp;
