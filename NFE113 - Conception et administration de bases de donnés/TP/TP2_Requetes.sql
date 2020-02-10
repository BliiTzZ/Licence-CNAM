-- TP3 

/* Q1) Noms et Prénoms des abonnées
 * habitant à Montpellier
 */

SELECT ab.nom, ab.prenom
FROM Abonne ab
WHERE ab.ville = 'MONTPELLIER'

/* Q2) Toutes les infos des exemplaires
 * dont le code de prêt égal à "EMPRUNTABLE"
 */

SELECT ex.*
FROM Exemplaire ex
WHERE ex.codePret = 'EMPRUNTABLE'

/* Q3) Liste de tout les ouvrages(ISBN, titre et catégorie)
 * avec le titre qui contient le mot "ROSE"
 * dans l'ordre decroissant de numero
 */

SELECT li.isbn, li.titre, li.categorie
FROM Livre li
WHERE li.titre LIKE '%ROSE%'
ORDER BY li.isbn DESC

/* Q4) liste de tout les livres (Titre et catégorie)
 * de toutes les catégories sauf Médecine, Sciences et Loisirs
 * trié par ordre alphabétique selon la catégorie
 */

SELECT li.titre, li.categorie
FROM Livre li
WHERE li.categorie <> 'LOISIRS'
AND li.categorie <> 'MEDECINE'
AND li.categorie <> 'SCIENCES'
ORDER BY li.categorie ASC

/* Q5) Toutes les informations des emprunts 
 * dont la date de retour réel n'est pas dans la base de donnée
 */

SELECT em.*
FROM Emprunt em
WHERE em.dateRetourReel = null

-- TP4

/* Q6) liste des exemplaires empruntés (numéro et date d'emprunt)
 * de Jean Dupont
 * par ordre croissant de date d'emprunt
 */

SELECT em.numero, em.dateEmprunt
FROM Emprunt em
INNER JOIN Abonne ab
ON ab.numeroAbonne = em.numeroAbonne
WHERE ab.nom = 'DUPONT'
AND ab.prenom = 'JEAN'
ORDER BY em.dateEmprunt ASC

/* Q7) Liste des exemplaires empruntés (numéro, code prêt et état)
 * du livre de titre "LE MUR"
 */

SELECT em.numero, ex.codePret, ex.etat
FROM Emprunt em
INNER JOIN Exemplaire ex
ON ex.numero = em.numero
INNER JOIN Livre li
ON li.isbn = ex.idIsbn
WHERE li.titre = 'LE MUR'

/* Q8) Liste des exemplaires (numéro, code prêt et titre)
 * d'un livre qui contient le mot clef "INFORMATIQUE"
 */

SELECT em.numero, ex.codePret, li.titre
FROM Emprunt em
INNER JOIN Exemplaire ex
ON ex.numero = em.numero
INNER JOIN Livre li
ON li.isbn = ex.idIsbn
INNER JOIN Caracterisation ca
ON ca.isbn = li.isbn
INNER JOIN MotCle mc
ON mc.mot = ca.mot
WHERE mc.mot = 'INFORMATIQUE'


/* Q9) Liste d'exemplaires (numéro)
 * ayant le meme livre que l'exemplaire 4112
 * dont l'état est "BON"
 */

SELECT ex.numero
FROM Exemplaire ex
WHERE ex.idIsbn = (
    SELECT ex.idIsbn
    FROM Exemplaire ex
    WHERE ex.numero = '4112'
)

/* Q10) Liste d'abonnés(numéro, nom et prénom)
 * ayant emprunté un exemplaire du livre "LE MUR"
 */

SELECT ab.numeroAbonne, ab.nom, ab.prenom
FROM Abonne ab
INNER JOIN Emprunt em
ON em.numeroAbonne = ab.numeroAbonne
INNER JOIN Exemplaire ex
ON ex.numero = em.numero
INNER JOIN Livre li
ON li.isbn = ex.idIsbn
WHERE li.titre = 'LE MUR'

/* Q11) Liste des catégories
 * dont aucun livre a été emprunté
 */

-- TP5

/* Q12) Liste d'abonnés dans la base
 */

SELECT ab.*
FROM Abonne ab

/* Q13) Nombre d'emprunts en cours
 * de l'abonné Renard Albert
 */

SELECT COUNT(em.numeroAbonne)
FROM Emprunt em
INNER JOIN Abonne ab
ON ab.numeroAbonne = em.numeroAbonne
WHERE ab.nom = 'RENARD'
AND ab.prenom = 'ALBERT'

/* Q14) Nombre d'abonnés 
 * qui as emprunté le livre "LE MIRACLE DE LA ROSE"
 */

SELECT COUNT(em.numeroAbonne)
FROM Emprunt em
INNER JOIN Exemplaire ex
ON ex.numero = em.numero
INNER JOIN Livre li
ON li.isbn = ex.idIsbn
WHERE li.titre = 'LE MIRACLE DE LA ROSE'

/* Q15) Prix d'achat moyen
 * des exemplaires de roman
 */

SELECT AVG(ex.prix)
FROM Exemplaire ex
INNER JOIN Livre li
ON li.isbn = ex.idIsbn
WHERE li.categorie = 'ROMAN'


/* Q16) Liste des abonnés (numéro, nom, prénom, montant)
 * uniquement si le montant est inferieur à 200€
 * en tenant compte d'avoir des valeurs manquantes 
 */

-- A finir
SELECT ab.numeroAbonne, ab.nom, ab.prenom,
(
    CASE
        WHEN ab.reduction IS NOT NULL THEN
            ab.tarif - (ab.tarif * ab.reduction / 100)
        ELSE 
            ab.tarif

    END
) AS montant
FROM Abonne ab
WHERE (
    CASE
        WHEN ab.reduction IS NOT NULL THEN
            ab.tarif - (ab.tarif * ab.reduction / 100)
        ELSE 
            ab.tarif

    END
) < 200

/* Q17) Tarif d'abonnement le plus faible
 */

SELECT MIN(ab.tarif)
FROM Abonne ab

/* Q18) Liste d'abonnés(numéro et nom)
 * dont le tarif est le plus faible
 */

-- A finir
SELECT ab.numeroAbonne, ab.nom
FROM Abonne ab
WHERE ab.tarif = MIN(ab.tarif)


/* Q19) Catégorie du livre
 * pour laquel l'exemplaire le plus cher à été acheté
 */

-- A finir

 -- TP6

/* Q20) Liste des titres des livres
 * indexés par un mot clef qui correspond à leur catégorie
 */

SELECT li.titre
FROM Livre li
INNER JOIN Caracterisation ca
ON ca.isbn = li.isbn
INNER JOIN MotCle mc
ON mc.mot = ca.mot
WHERE mc.mot = li.categorie

/* Q21) liste d'exemplaires (numéro)
 * dans l'état abimé
 * et qui sont actuellement empruntés
 */

-- A finir
SELECT ex.numero
FROM Exemplaire ex
INNER JOIN Emprunt em
ON em.numero = ex.numero
WHERE ex.etat = 'ABIME'

/* Q22) Liste de mots clefs
 * ne caractérisant aucun livre
 */

-- A finir
SELECT mc.mot
FROM MotCle mc
INNER JOIN Caracterisation ca
ON ca.mot = mc.mot

/* Q23) Liste d'abonnés (numéro et nom)
 * relancés pour un emprunt en cours
 * ainsi que ceux ayant moins de 16 ans
 */

 SELECT ab.numeroAbonne, ab.nom
 FROM Abonne ab
 INNER JOIN Emprunt em
 ON em.numeroAbonne = ab.numeroAbonne
 WHERE ab.age > 16

