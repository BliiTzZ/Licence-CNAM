DROP TABLE IF EXISTS Abonnement;

DROP TABLE IF EXISTS Bibliotheque;

DROP TABLE IF EXISTS Emprunt;

DROP TABLE IF EXISTS Domiciliation;

DROP TABLE IF EXISTS Ville;

DROP TABLE IF EXISTS Abonne;

DROP TABLE IF EXISTS Habitant;

DROP TABLE IF EXISTS PersonnePhysique;

DROP TABLE IF EXISTS Exemplaire;

DROP TABLE IF EXISTS Caracterisation;

DROP TABLE IF EXISTS MotCle;

DROP TABLE IF EXISTS LivreTraduit;

DROP TABLE IF EXISTS LivreOriginal;

DROP TABLE IF EXISTS Livre;

create table Livre(
	idLivre SERIAL PRIMARY KEY,
	isbn VARCHAR(20) NOT NULL,
	titre VARCHAR(100) NOT NULL,
	langue VARCHAR(2)
	CONSTRAINT langue_DK CHECK(langue IN ('FR', 'BR', 'SP'))
);

create table LivreOriginal(
	siecle INT,
	categorie VARCHAR(30),
	CONSTRAINT siecle_DK CHECK(siecle BETWEEN 0 AND 21)
) INHERITS(Livre);

create table LivreTraduit(
	idLivreOriginal INT NOT NULL
	-- Mettre un Trigger
) INHERITS(Livre);

create table MotCle(
	idMotCle SERIAL PRIMARY KEY,
	mot VARCHAR(30) NOT NULL
);

create table Caracterisation(
	idLivre INT NOT NULL,
	idMotCle INT NOT NULL,
	CONSTRAINT tabRelCaracterisation_PKEY PRIMARY KEY(idLivre, idMotCle),
	CONSTRAINT relCaracterisationToIsbn_FK FOREIGN KEY(idMotCle) REFERENCES Livre(idLivre),
	CONSTRAINT relCaracterisationToMot_FK FOREIGN KEY(idMotCle) REFERENCES MotCle(idMotCle)	
);

create table Exemplaire(
	idExemplaire SERIAL PRIMARY KEY,
	numero INT NOT NULL,
	dateAchat DATE,
	prix REAL,
	codePret VARCHAR(20),
	Etat VARCHAR(20),
	idLivre INT NOT NULL,
	CONSTRAINT code_pret_DK CHECK(codePret IN ('EXCLU', 'EMPRUNTABLE', 'CONSULTABLE')),
	CONSTRAINT etat_DK CHECK(etat IN ('BON', 'ABIME', 'EN_REPARATION')),
	CONSTRAINT exemplaireToLivre_FK FOREIGN KEY(idLivre) REFERENCES Livre(idLivre)
);

create table PersonnePhysique(
	idPersonnePhysique SERIAL PRIMARY KEY,
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30) NOT NULL,
	age INT NOT NULL
	CONSTRAINT age_DK CHECK(age BETWEEN 0 AND 120)
);

create table Habitant(

) INHERITS(PersonnePhysique);

create table Abonne(

) INHERITS(Habitant);

create table Ville(
	idVille SERIAL PRIMARY KEY,
	nom VARCHAR(100) NOT NULL
);

create table Domiciliation(
	idVille INT NOT NULL,
	idPersonnePhysique INT NOT NULL,
	CONSTRAINT tabRelDomiciliation_PKEY PRIMARY KEY(idVille, idPersonnePhysique),
	CONSTRAINT relDomiciliationToIdLivre_FK FOREIGN KEY(idVille) REFERENCES Ville(idVille)
	-- Mettre un Trigger
);

create table Emprunt(
	idPersonnePhysique INT NOT NULL,
	idExemplaire INT NOT NULL,
	dateEmprunt DATE NOT NULL,
	dateRetourPrevue DATE NOT NULL,
	dateRetourReel DATE,
	nbRelance INT,
	CONSTRAINT nb_relance_DK CHECK(nbRelance IN (1, 2, 3)),
	CONSTRAINT tabRelEmprunt_PKEY PRIMARY KEY(idPersonnePhysique,idExemplaire,dateEmprunt),
	-- Mettre un Trigger
	CONSTRAINT relEmpruntToIdExemplaire_FK FOREIGN KEY(idExemplaire) REFERENCES Exemplaire(idExemplaire)
);

create table Bibliotheque(
	idBibliotheque SERIAL PRIMARY KEY,
	nom VARCHAR(100) NOT NULL
);

create table Abonnement(
	idPersonnePhysique INT NOT NULL,
	idBibliotheque INT NOT NULL,
	numeroAbonne INT NOT NULL,
	tarif REAL,
	reduction REAL,
	CONSTRAINT tabRelAbonnement_PKEY PRIMARY KEY(idPersonnePhysique,idBibliotheque),
	-- Mettre un Trigger
	CONSTRAINT relAbonnementToIdidBibliotheque_FK FOREIGN KEY(idBibliotheque) REFERENCES Bibliotheque(idBibliotheque)
);