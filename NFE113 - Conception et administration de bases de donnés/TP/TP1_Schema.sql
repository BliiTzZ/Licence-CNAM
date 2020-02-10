DROP TABLE IF EXISTS Emprunt;

DROP TABLE IF EXISTS Abonne;

DROP TABLE IF EXISTS Exemplaire;

DROP TABLE IF EXISTS Caracterisation;

DROP TABLE IF EXISTS MotCle;

DROP TABLE IF EXISTS Livre;

create table Livre(
	isbn VARCHAR(20) PRIMARY KEY NOT NULL,
	titre VARCHAR(100) NOT NULL,
	siecle INT,
	categorie VARCHAR(30),
	CONSTRAINT siecle_DK CHECK(siecle BETWEEN 0 AND 21)
);

create table MotCle(
	mot VARCHAR(30) PRIMARY KEY NOT NULL
);

create table Caracterisation(
	isbn VARCHAR(20),
	mot VARCHAR(30),
	CONSTRAINT tabRelCaracterisation_PKEY PRIMARY KEY(isbn, mot),
	CONSTRAINT relCaracterisationToIsbn_FK FOREIGN KEY(isbn) REFERENCES Livre(isbn),
	CONSTRAINT relCaracterisationToMot_FK FOREIGN KEY(mot) REFERENCES MotCle(mot)	
);

create table Exemplaire(
	numero INT PRIMARY KEY NOT NULL,
	dateAchat DATE,
	prix REAL,
	codePret VARCHAR(20),
	Etat VARCHAR(20),
	idIsbn VARCHAR(20) NOT NULL,
	CONSTRAINT code_pret_DK CHECK(codePret IN ('EXCLU', 'EMPRUNTABLE', 'CONSULTABLE')),
	CONSTRAINT etat_DK CHECK(etat IN ('BON', 'ABIME', 'EN_REPARATION')),
	CONSTRAINT exemplaireToLivre_FK FOREIGN KEY(idIsbn) REFERENCES Livre(isbn)
);

create table Abonne(
	numeroAbonne INT PRIMARY KEY NOT NULL,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	age INT,
	tarif REAL,
	reduction REAL,
	ville VARCHAR(30),
	CONSTRAINT age_DK CHECK(age BETWEEN 0 AND 120)
);

create table Emprunt(
	numeroAbonne INT NOT NULL,
	numero  INT NOT NULL,
	dateEmprunt DATE NOT NULL,
	dateRetourPrevue DATE NOT NULL,
	dateRetourReel DATE,
	nbRelance INT,
	CONSTRAINT nb_relance_DK CHECK(nbRelance IN (1, 2, 3)),
	CONSTRAINT tabRelEmprunt_PKEY PRIMARY KEY(numeroAbonne, numero,dateEmprunt),
	CONSTRAINT relEmpruntToNumeroAbonne_FK FOREIGN KEY(numeroAbonne) REFERENCES Abonne(numeroAbonne),
	CONSTRAINT relEmpruntToNumero_FK FOREIGN KEY(numero) REFERENCES Exemplaire(numero)
);