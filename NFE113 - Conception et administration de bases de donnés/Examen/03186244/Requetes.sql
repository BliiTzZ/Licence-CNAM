
/**
 * R1
 */
SELECT DISTINCT pe.id_personne, pe.nom, pe.prenom
FROM personne pe
INNER JOIN Propriete pro
ON pro.id_personne = pe.id_personne

/**
 * R2
 */
SELECT pe.id_personne, pe.nom, pe.prenom, e.marque, e.reference
FROM personne pe
INNER JOIN Propriete pro
ON pro.id_personne = pe.id_personne
INNER JOIN Electromenager e
ON e.id_electromenager = pro.id_electromenager

/**
 * R3
 */
SELECT e.marque, e.reference
FROM Electromenager e
LEFT JOIN Propriete pro
ON pro.id_electromenager = e.id_electromenager
WHERE pro.id_electromenager IS NULL

/**
 * R4
 */
SELECT pe.id_personne, pe.nom, pe.prenom, e.reference,e.prix
FROM Personne pe
INNER JOIN Propriete pro
on pro.id_personne = pe.id_personne
INNER JOIN Electromenager e
on e.id_electromenager = pro.id_electromenager
WHERE e.prix < 100

/**
 * R5
 */
SELECT *
FROM Propriete pro
INNER JOIN Electromenager e
on e.id_electromenager = pro.id_electromenager

/**
 * R6
 */
SELECT *
FROM Personne pe
INNER JOIN Propriete pro
on pro.id_personne = pe.id_personne
INNER JOIN Electromenager e
on e.id_electromenager = pro.id_electromenager

/**
 * R7
 */
SELECT *
FROM Propriete pro
LEFT JOIN Electromenager e
on e.id_electromenager = pro.id_electromenager

/**
 * R8
 */
SELECT *
FROM Propriete pro
RIGHT JOIN Electromenager e
on e.id_electromenager = pro.id_electromenager