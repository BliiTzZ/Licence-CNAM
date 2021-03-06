

SET SERVEROUTPUT ON;
SET FEEDBACK OFF;
EXECUTE IF_EXIST_DROP_TABLE('TP01_CARACTERISATION');
EXECUTE IF_EXIST_DROP_TABLE('TP01_MOT_CLEF');
EXECUTE IF_EXIST_DROP_TABLE('TP01_EMPRUNT');
EXECUTE IF_EXIST_DROP_TABLE('TP01_EXEMPLAIRE');
EXECUTE IF_EXIST_DROP_TABLE('TP01_LIVRE');
EXECUTE IF_EXIST_DROP_TABLE('TP01_ABONNE');
SET FEEDBACK ON;







CREATE TABLE TP01_ABONNE(
	NUMERO_ABONNE INTEGER,
	NOM VARCHAR2(20) NOT NULL,
	PRENOM VARCHAR2(20),
	AGE INTEGER,
	TARIF REAL,
	REDUCTION REAL,
	VILLE VARCHAR2(30),
	CONSTRAINT TP01_ABONNE_PK PRIMARY KEY (NUMERO_ABONNE),
	CONSTRAINT TP01_AGE_DK CHECK (AGE BETWEEN 0 AND 120)
);





CREATE TABLE TP01_LIVRE(
	ISBN VARCHAR2(20),
	TITRE VARCHAR2(50) NOT NULL,
	SIECLE INTEGER CHECK (SIECLE BETWEEN 0 AND 21),
	CATEGORIE VARCHAR2(20),
	CONSTRAINT TP01_LIVRE_PK PRIMARY KEY (ISBN)
);





CREATE TABLE TP01_EXEMPLAIRE(
	NUMERO INTEGER,
	DATE_ACHAT DATE,
	PRIX REAL,
	CODE_PRET VARCHAR2(20),
	ETAT VARCHAR2(15) CHECK (ETAT IN ('BON','ABIME','EN_REPARATION')),
	ISBN VARCHAR2(20),
	CONSTRAINT TP01_EXEMPLAIRE_PK PRIMARY KEY (NUMERO),
	CONSTRAINT TP01_EXEMPLAIRETOLIVRE_FK FOREIGN KEY (ISBN) REFERENCES TP01_LIVRE(ISBN),
	CONSTRAINT TP01_CODE_PRET_DK CHECK (CODE_PRET IN ('EXCLU', 'EMPRUNTABLE', 'CONSULTABLE')) 
);





CREATE TABLE TP01_EMPRUNT(
	NUMERO_ABONNE INTEGER,
	NUMERO INTEGER,
	DATE_EMPRUNT DATE,
	DATE_RETOUR DATE,
	DATE_RETOUR_REEL DATE,
	NB_RELANCE INTEGER CHECK (NB_RELANCE IN (1,2,3)),
	CONSTRAINT TP01_EMPRUNT_PK PRIMARY KEY (NUMERO_ABONNE,NUMERO,DATE_EMPRUNT),
	CONSTRAINT TP01_EMPRUNTTOABONNE_FK FOREIGN KEY (NUMERO_ABONNE) REFERENCES TP01_ABONNE(NUMERO_ABONNE),
	CONSTRAINT TP01_EMPRUNTTOEXEMPLAIRE_FK FOREIGN KEY (NUMERO) REFERENCES TP01_EXEMPLAIRE(NUMERO)
);





CREATE TABLE TP01_MOT_CLEF (
	MOT VARCHAR2(20),
	CONSTRAINT TP01_MOT_CLEF_PK PRIMARY KEY (MOT)
);





CREATE TABLE TP01_CARACTERISATION(
	ISBN VARCHAR2(20),
	MOT VARCHAR2(20),
	CONSTRAINT TP01_CARACT_PK PRIMARY KEY (ISBN,MOT),
	CONSTRAINT TP01_CARACTTOLIVRE_FK FOREIGN KEY (ISBN) REFERENCES TP01_LIVRE(ISBN),
	CONSTRAINT TP01_CARACTTOMOT_CLEF_FK FOREIGN KEY (MOT) REFERENCES TP01_MOT_CLEF(MOT)
);
