DROP TRIGGER IF EXISTS "check_idExistInAbonneTableOnAbonnement" ON abonnement;
DROP FUNCTION IF EXISTS "mir_idExistInAbonneTableOnAbonnement"();
DROP TRIGGER IF EXISTS "check_idExistInExemplaireTableOnEmprunt" ON emprunt;
DROP FUNCTION IF EXISTS "mir_idExistInExemplaireTableOnEmprunt"();
DROP TRIGGER IF EXISTS "check_idExistInLivreTableOnExemplaire" ON exemplaire;
DROP TRIGGER IF EXISTS "check_idExistInLivreTableOnCaracterisation" ON caracterisation;
DROP FUNCTION IF EXISTS "mir_idExistInLivreTable"();
DROP TRIGGER IF EXISTS "check_idUniciteInLivreTableTraduit" ON livretraduit;
DROP TRIGGER IF EXISTS "check_idUniciteInLivreTableOriginal" ON livreoriginal;
DROP FUNCTION IF EXISTS "mir_idUniciteInLivreTable"();
DROP TRIGGER IF EXISTS "check_livreTableAbstraite" ON livre;
DROP FUNCTION IF EXISTS "mir_livreTableAbstraite"();
DROP TRIGGER IF EXISTS "check_idExistInHabitantTableOnDomiciliation" ON domiciliation;
DROP FUNCTION IF EXISTS "mir_idExistInHabitantTableOnDomiciliation"();
DROP TRIGGER IF EXISTS "check_idUniciteInAbonneTable" ON abonne;
DROP TRIGGER IF EXISTS "check_idUniciteInHabitantTable" ON habitant;
DROP TRIGGER IF EXISTS "check_idUniciteInPersonnePhysiqueTable" ON personnephysique;
DROP FUNCTION IF EXISTS "mir_idUniciteInPersonnePhysiqueTable"();
DROP PROCEDURE IF EXISTS "mir_updatePersonnePhysiqueSequence";

CREATE OR REPLACE PROCEDURE "mir_updatePersonnePhysiqueSequence"()
LANGUAGE plpgsql
AS $$
DECLARE
	idMax INTEGER;
	sequenceName VARCHAR;
BEGIN
	SELECT MAX(idpersonnephysique)
		INTO idMax
			FROM personnephysique;
	SELECT sequence_name
		INTO sequenceName
			FROM information_schema.sequences
				WHERE sequence_name LIKE '%personnephysique%';
	EXECUTE 'ALTER SEQUENCE ' || sequenceName || ' RESTART ' || idMax;	
END
$$;










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





CREATE OR REPLACE FUNCTION "mir_idUniciteInPersonnePhysiqueTable"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdPersonnePhysique INTEGER;
BEGIN
	SELECT COUNT(idpersonnephysique)
		INTO nbIdPersonnePhysique
			FROM personnephysique
				WHERE idpersonnephysique = NEW.idpersonnephysique;
	IF nbIdPersonnePhysique > 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) existe déjà dans la table PERSONNEPHYSIQUE.', NEW.idpersonnephysique;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idUniciteInPersonnePhysiqueTable"
	BEFORE INSERT ON personnephysique
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idUniciteInPersonnePhysiqueTable"();

CREATE TRIGGER "check_idUniciteInHabitantTable"
	BEFORE INSERT ON habitant
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idUniciteInPersonnePhysiqueTable"();

CREATE TRIGGER "check_idUniciteInAbonneTable"
	BEFORE INSERT ON abonne
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idUniciteInPersonnePhysiqueTable"();
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





CREATE OR REPLACE FUNCTION "mir_idExistInHabitantTableOnDomiciliation"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdPersonnePhysique INTEGER;
BEGIN
	SELECT COUNT(idpersonnephysique)
		INTO nbIdPersonnePhysique
			FROM habitant
				WHERE idpersonnephysique = NEW.idpersonnephysique;
	IF nbIdPersonnePhysique = 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) n''existe pas dans la table HABITANT.', NEW.idpersonnephysique;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idExistInHabitantTableOnDomiciliation"
	BEFORE INSERT ON domiciliation
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idExistInHabitantTableOnDomiciliation"();
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





CREATE OR REPLACE FUNCTION "mir_idUniciteInLivreTable"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdLivre INTEGER;
BEGIN
	SELECT COUNT(idlivre)
		INTO nbIdLivre
			FROM livre
				WHERE idlivre = NEW.idlivre;
	IF nbIdLivre > 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) existe déjà dans la table LIVRE.', NEW.idlivre;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idUniciteInLivreTableOriginal"
	BEFORE INSERT ON livreoriginal
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idUniciteInLivreTable"();

CREATE TRIGGER "check_idUniciteInLivreTableTraduit"
	BEFORE INSERT ON livretraduit
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idUniciteInLivreTable"();
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





CREATE OR REPLACE FUNCTION "mir_idExistInLivreTable"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdlivre INTEGER;
BEGIN
	SELECT COUNT(idlivre)
		INTO nbIdlivre
			FROM livre
				WHERE idlivre = NEW.idlivre;
	IF nbIdlivre = 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) n''existe pas dans la table LIVRE.', NEW.idlivre;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idExistInLivreTableOnCaracterisation"
	BEFORE INSERT ON caracterisation
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idExistInLivreTable"();
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





CREATE TRIGGER "check_idExistInLivreTableOnExemplaire"
	BEFORE INSERT ON exemplaire
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idExistInLivreTable"();





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





CREATE OR REPLACE FUNCTION "mir_idExistInExemplaireTableOnEmprunt"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdExemplaire INTEGER;
BEGIN
	SELECT COUNT(idexemplaire)
		INTO nbIdExemplaire
			FROM exemplaire
				WHERE idexemplaire = NEW.idexemplaire;
	IF nbIdExemplaire = 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) n''existe pas dans la table EXEMPLAIRE.', NEW.idExemplaire;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idExistInExemplaireTableOnEmprunt"
	BEFORE INSERT ON emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idExistInExemplaireTableOnEmprunt"();
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





CREATE OR REPLACE FUNCTION "mir_idExistInAbonneTableOnAbonnement"() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nbIdPersonnePhysique INTEGER;
BEGIN
	SELECT COUNT(idpersonnephysique)
		INTO nbIdPersonnePhysique
			FROM Abonne
				WHERE idpersonnephysique = NEW.idpersonnephysique;
	IF nbIdPersonnePhysique = 0 THEN
		RAISE EXCEPTION 'L''identifiant (%) n''existe pas dans la table ABONNE.', NEW.idpersonnephysique;
		END IF;
	RETURN NEW;
END
$BODY$;


CREATE TRIGGER "check_idExistInAbonneTableOnAbonnement"
	BEFORE INSERT ON abonnement
	FOR EACH ROW
	EXECUTE PROCEDURE "mir_idExistInAbonneTableOnAbonnement"();
/* Bibliothéque *********************************************************************************************/







