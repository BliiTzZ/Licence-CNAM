DELETE FROM Abonnement;

DELETE FROM Bibliotheque;

DELETE FROM Emprunt;

DELETE FROM Domiciliation;

DELETE FROM Ville;

DELETE FROM Abonne;

DELETE FROM Habitant;

DELETE FROM PersonnePhysique;

DELETE FROM Exemplaire;

DELETE FROM Caracterisation;

DELETE FROM MotCle;

DELETE FROM LivreTraduit;

DELETE FROM LivreOriginal;

DELETE FROM Livre;

-- Données de la table Livre

INSERT INTO Livre(isbn,titre,langue)
SELECT isbn, titre, 'FR'
FROM temp.Livre

UPDATE Livre
SET langue = 'BR'
WHERE isbn = '0_201_14439_5'

UPDATE Livre
SET langue = 'BR'
WHERE isbn = '0_12_27550_2'

-- Données de la table MotCle

INSERT INTO MotCle(mot)
SELECT mot
FROM temp.MotCle

-- Données de la table Caracterisation

INSERT INTO Caracterisation(idLivre, idMotCle)
INSERT INTO Caracterisation(isbn,mot)
VALUES('1_104_1050_2','LITTERATURE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_15_270500_3','LITTERATURE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_15_270500_3','ROMAN');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_85_4107_3','LITTERATURE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_85_4107_3','ROMAN');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_112_3785_5','LITTERATURE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_112_3785_5','POESIE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_201_14439_5','SCIENCES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_201_14439_5','INFORMATIQUE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_201_14439_5','BASES DE DONNEES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_12_27550_2','SCIENCES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_12_27550_2','INFORMATIQUE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_8_7707_2','SCIENCES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_8_7707_2','INFORMATIQUE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_8_7707_2','BASES DE DONNEES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('1_22_1721_3','ROMAN');

INSERT INTO Caracterisation(isbn,mot)
VALUES('1_22_1721_3','HISTOIRE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('3_505_13700_5','LITTERATURE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('3_505_13700_5','ROMAN');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_26_28079_6','SCIENCES');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_26_28079_6','INFORMATIQUE');

INSERT INTO Caracterisation(isbn,mot)
VALUES('0_26_28079_6','BASES DE DONNEES');

-- Données de la table Exemplaire

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1010,'10-04-1985',55,'EMPRUNTABLE','BON','0_18_47892_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1011,'10-04-1985',55,'EMPRUNTABLE','BON','0_18_47892_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1012,'20-05-1985',112,'EMPRUNTABLE','BON','3_505_13700_5');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(2909,'30-03-1990',35,'EMPRUNTABLE','BON','3_505_13700_5');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(2673,'15-03-1991',42,'EMPRUNTABLE','ABIME','3_505_13700_5');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(2710,'20-06-1984',270,'CONSULTABLE','BON','0_8_7707_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(2711,'20-06-1984',270,'EMPRUNTABLE','BON','0_8_7707_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(3014,'15-09-1990',420,'CONSULTABLE','BON','0_201_14439_5');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(3016,'15-09-1990',420,'EMPRUNTABLE','BON','0_201_14439_5');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(3702,'20-02-1992',210,'EMPRUNTABLE','BON','1_22_1721_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(3703,'20-02-1992',210,'CONSULTABLE','BON','1_22_1721_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(4111,'03-01-1995',48,'EMPRUNTABLE','BON','1_22_1721_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(4112,'03-01-1995',48,'EXCLU','BON','1_22_1721_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(4203,'29-11-1992',35,'EMPRUNTABLE','BON','1_104_1050_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(4204,'29-11-1992',35,'EMPRUNTABLE','ABIME','1_104_1050_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5003,'10-06-1993',39,'EMPRUNTABLE','BON','1_104_1050_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5004,'10-06-1993',41,'EMPRUNTABLE','BON','0_15_270500_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5005,'10-06-1993',41,'EMPRUNTABLE','BON','0_15_270500_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5103,'20-12-1990',470,'CONSULTABLE','BON','0_12_27550_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5104,'20-12-1990',470,'EMPRUNTABLE','BON','0_12_27550_2');
INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(6006,'15-12-1995',33,'EMPRUNTABLE','BON','0_85_4107_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(6007,'15-12-1995',33,'EMPRUNTABLE','BON','0_85_4107_3');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(5202,'18-10-1993',40,'EMPRUNTABLE','BON','0_18_47892_2');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(7000,'01-09-1987',420,'CONSULTABLE','BON','2_7296_0040');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(7001,'01-09-1987',420,'EMPRUNTABLE','BON','2_7296_0040');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(7002,'01-09-1987',420,'EXCLU','BON','2_7296_0040');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1090,'23-11-1985',150,'EXCLU','ABIME','9_782070_36');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1091,'23-11-1985',150,'CONSULTABLE','EN_REPARATION','9_782070_36');

INSERT INTO Exemplaire(numero,dateAchat,prix,codePret,Etat,idIsbn)
VALUES(1109,'30-05-1987',170,'EMPRUNTABLE','BON','9_782070_36');

-- Données de la table Abonne

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(901001,'LEVEQUE','PIERRE',40,500,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(902043,'DUPONT','03IE',20,200,20,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(902075,'RENARD','ALBERT',18,200,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(911007,'03TIN','LOIC',35,500,20,'BEZIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(911021,'DUPONT','ANTOINE',38,500,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(911022,'DUPONT','SYLVIE',35,500,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(911023,'DUPONT','JEAN',22,200,20,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(922016,'MEUNIER','LUC',14,100,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(921102,'LUCAS','PAUL',48,500,20,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(922143,'REVEST','ANNIE',12,100,NULL,'MONTPELLIER');

INSERT INTO Abonne(numeroAbonne,nom,prenom,age,tarif,reduction,ville)
VALUES(932010,'ANTON','JEANNE',10,100,NULL,'MONTPELLIER');

-- Données de la table Emprunt

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,5003,'10-03-2002','30-03-2002','30-03-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,5005,'30-03-2002','15-04-2002','10-04-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,1012,'30-03-2002','15-04-2002','10-04-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,5103,'17-06-2002','30-06-2002','20-07-2002',1);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(901001,4203,'03-01-2001','18-01-2001','18-01-2001',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(901001,5005,'03-01-2001','18-01-2001','18-01-2001',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911007,4203,'25-02-2001','08-03-2001','25-03-2001',1);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911007,1010,'13-05-2001','31-05-2001','31-05-2001',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(921102,4204,'08-08-2002','22-08-2002','30-08-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(921102,5005,'08-08-2002','22-08-2002','30-08-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911021,5004,'10-12-2002','30-12-2002','28-12-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911007,5004,'20-07-2002','10-08-2002','10-08-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911007,4204,'19-01-2003','10-02-2003',NULL,1);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911007,2673,'10-12-2002','30-12-2002','28-12-2002',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902075,2673,'15-02-2003','28-02-2003',NULL,NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902075,1010,'05-01-2003','25-01-2003',NULL,1);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(921102,6006,'20-12-2002','10-01-2003',NULL,2);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,6007,'22-12-2002','12-01-2003','13-01-2003',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902043,7001,'15-09-2000','09-10-2000','10-10-2000',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902043,3014,'01-10-2000','21-10-2000','20-11-2000',2);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902043,3014,'01-12-2000','20-12-2000','20-12-2000',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(911023,1109,'15-09-2002','05-10-2002','05-11-2002',2);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(902043,7001,'20-11-2000','10-12-2000','10-12-2000', NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(901001,7001,'30-01-2000','20-02-2000','18-02-2000',NULL);

INSERT INTO Emprunt(numeroAbonne,numero,dateEmprunt,dateRetourPrevue,dateRetourReel,nbRelance)
VALUES(901001,7001,'22-05-2002','12-06-2002','15-06-2002',NULL);