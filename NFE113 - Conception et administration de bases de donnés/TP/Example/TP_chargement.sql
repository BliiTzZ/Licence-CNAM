DELETE FROM ABONNEMENT;
DELETE FROM BIBLIOTHEQUE;
DELETE FROM EMPRUNT;
DELETE FROM EXEMPLAIRE;
DELETE FROM CARACTERISATION;
DELETE FROM MOT_CLEF;
DELETE FROM LIVRETRADUIT;
DELETE FROM LIVREORIGINAL;
DELETE FROM LIVRE;
DELETE FROM DOMICILIATION;
DELETE FROM VILLE;
DELETE FROM ABONNE;
DELETE FROM HABITANT;
DELETE FROM PERSONNEPHYSIQUE;









/* Hiérarchie Personne Physique *****************************************************************************/
INSERT INTO PERSONNEPHYSIQUE(NOM, PRENOM, AGE) VALUES('LORCA', 'BERNARD', 15);
INSERT INTO PERSONNEPHYSIQUE(NOM, PRENOM, AGE) VALUES('CLANET', 'LUCIEN', 40);





INSERT INTO HABITANT(NOM, PRENOM, AGE) VALUES('NABILA', 'ZOE', 78);
INSERT INTO HABITANT(NOM, PRENOM, AGE) VALUES('HUGO', 'EMILE', 53);





DROP TABLE IF EXISTS TMP.NEWOLDABONNEID;
CREATE TABLE TMP.NEWOLDABONNEID AS 
	SELECT ROW_NUMBER() OVER() + (
									SELECT MAX (IDPERSONNEPHYSIQUE)
										FROM PERSONNEPHYSIQUE) AS IDNEW, NUMERO_ABONNE AS IDOLD
		FROM TMP.ABONNE;





INSERT INTO ABONNE
	SELECT IDNEW, NOM, PRENOM, AGE
		FROM TMP.NEWOLDABONNEID I, TMP.ABONNE A
			WHERE I.IDOLD = A.NUMERO_ABONNE;


/* Ville ****************************************************************************************************/
INSERT INTO VILLE(NOM)
	SELECT DISTINCT VILLE
		FROM TMP.ABONNE;





INSERT INTO DOMICILIATION 
							SELECT (SELECT IDVILLE
										FROM VILLE 
											WHERE NOM = 'MONTPELLIER'),
									(SELECT IDPERSONNEPHYSIQUE
										FROM HABITANT
											WHERE NOM = 'NABILA' AND PRENOM = 'ZOE' AND AGE = 78);
INSERT INTO DOMICILIATION 
							SELECT (SELECT IDVILLE
										FROM VILLE 
											WHERE NOM = 'BEZIER'),
									(SELECT IDPERSONNEPHYSIQUE
										FROM HABITANT
											WHERE NOM = 'HUGO' AND PRENOM = 'EMILE' AND AGE = 53);





INSERT INTO DOMICILIATION 
	SELECT V.IDVILLE, I.IDNEW FROM VILLE V, TMP.ABONNE A, TMP.NEWOLDABONNEID I
		WHERE V.NOM = A.VILLE AND A.NUMERO_ABONNE = I.IDOLD;
/* Ville ****************************************************************************************************/










/* Hiérarchie Livre *****************************************************************************************/
INSERT INTO LIVREORIGINAL(ISBN, TITRE, LANGUE, SIECLE, CATEGORIE)
	SELECT ISBN, TITRE, 'FR', SIECLE, CATEGORIE
		FROM TMP.LIVRE;





UPDATE LIVREORIGINAL
	SET LANGUE = 'BR'
		WHERE TITRE = 'AN INTRODUCTION TO DATABASE SYSTEMS';
UPDATE LIVREORIGINAL
	SET LANGUE = 'BR'
		WHERE TITRE = 'NEW APPLICATIONS OF DATABASES';





INSERT INTO LIVRETRADUIT(ISBN, TITRE, LANGUE, IDLIVREORIGINAL)
	SELECT '014017737X', 'THE PEARL', 'BR', (SELECT IDLIVRE
												FROM LIVREORIGINAL
													WHERE TITRE = 'LA PERLE');
INSERT INTO LIVRETRADUIT(ISBN, TITRE, LANGUE, IDLIVREORIGINAL)
	SELECT '0465026567', 'GÖDEL ESCHER BACH: AN ETERNAL GOLDEN BRAID', 'BR', (SELECT IDLIVRE
																				FROM LIVREORIGINAL
																					WHERE TITRE = 'GODEL ESCHER BACH : LES BRINS D''UNE GUIRLANDE');
INSERT INTO LIVRETRADUIT(ISBN, TITRE, LANGUE, IDLIVREORIGINAL)
	SELECT '2220080234', 'NOUVELLES APPLICATIONS DES BASES DE DONNÉES', 'FR', (SELECT IDLIVRE
																				FROM LIVREORIGINAL
																					WHERE TITRE = 'NEW APPLICATIONS OF DATABASES');
/* Hiérarchie Livre *****************************************************************************************/










/* Mot clé **************************************************************************************************/
INSERT INTO MOT_CLEF(MOT)
	SELECT *
		FROM TMP.MOT_CLEF;





INSERT INTO CARACTERISATION
SELECT L.IDLIVRE, M.IDMOT FROM LIVREORIGINAL L, TMP.CARACTERISATION C, MOT_CLEF M
	WHERE L.ISBN = C.ISBN AND C.MOT = M.MOT;
/* Mot clé **************************************************************************************************/










/* Exemplaire ***********************************************************************************************/
INSERT INTO EXEMPLAIRE(NUMERO, DATE_ACHAT, PRIX, CODE_PRET, ETAT, IDLIVRE)
	SELECT NUMERO, DATE_ACHAT, PRIX, CODE_PRET, ETAT, L.IDLIVRE
		FROM TMP.EXEMPLAIRE E, LIVRE L
			WHERE E.ISBN = L.ISBN;





INSERT INTO EXEMPLAIRE(NUMERO, DATE_ACHAT, PRIX, CODE_PRET, ETAT, IDLIVRE)
	SELECT 10000, '10-04-1985', 1000, 'EMPRUNTABLE', 'BON', (SELECT IDLIVRE
																FROM LIVRE
																	WHERE TITRE = 'THE PEARL');
INSERT INTO EXEMPLAIRE(NUMERO, DATE_ACHAT, PRIX, CODE_PRET, ETAT, IDLIVRE)
	SELECT 12000, '11-05-1999', 1500, 'EMPRUNTABLE', 'BON', (SELECT IDLIVRE
																FROM LIVRE
																	WHERE TITRE = 'GÖDEL ESCHER BACH: AN ETERNAL GOLDEN BRAID');
INSERT INTO EXEMPLAIRE(NUMERO, DATE_ACHAT, PRIX, CODE_PRET, ETAT, IDLIVRE)
	SELECT 13000, '27-10-2014', 2000, 'EMPRUNTABLE', 'BON', (SELECT IDLIVRE
																FROM LIVRE
																	WHERE TITRE = 'NOUVELLES APPLICATIONS DES BASES DE DONNÉES');





INSERT INTO EMPRUNT
	SELECT IDNEW, IDEXEMPLAIRE, DATE_EMPRUNT, DATE_RETOUR, DATE_RETOUR_REEL, NB_RELANCE
		FROM TMP.NEWOLDABONNEID N, EXEMPLAIRE EX, TMP.EMPRUNT E
			WHERE N.IDOLD = E.NUMERO_ABONNE AND EX.NUMERO = E.NUMERO;
/* Exemplaire ***********************************************************************************************/










/* Bibliothéque *********************************************************************************************/
INSERT INTO BIBLIOTHEQUE(NOM) VALUES('EMILE ZOLA');
INSERT INTO BIBLIOTHEQUE(NOM) VALUES('VICTOR HUGO');





INSERT INTO ABONNEMENT
	SELECT IDNEW, (SELECT IDBIBLIOTHEQUE FROM BIBLIOTHEQUE WHERE NOM = 'EMILE ZOLA'), NUMERO_ABONNE, TARIF, REDUCTION
		FROM TMP.NEWOLDABONNEID N, TMP.ABONNE A
			WHERE NOM = 'DUPONT' AND N.IDOLD = A.NUMERO_ABONNE;
INSERT INTO ABONNEMENT
	SELECT IDNEW, (SELECT IDBIBLIOTHEQUE FROM BIBLIOTHEQUE WHERE NOM = 'VICTOR HUGO'), NUMERO_ABONNE, TARIF, REDUCTION
		FROM TMP.NEWOLDABONNEID N, TMP.ABONNE A
			WHERE NOM != 'DUPONT' AND N.IDOLD = A.NUMERO_ABONNE;
/* Bibliothéque *********************************************************************************************/








DROP TABLE IF EXISTS TMP.NEWOLDABONNEID;



