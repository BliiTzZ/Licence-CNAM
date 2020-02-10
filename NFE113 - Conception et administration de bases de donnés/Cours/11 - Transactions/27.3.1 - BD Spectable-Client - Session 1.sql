delete from Client;
delete from Spectacle;
insert into Client values (1, 'Philippe', 0, 2000);
insert into Client values (2, 'Julie', 0, 350);
insert into Spectacle values (1, 'Ben hur', 250, 50, 15);
insert into Spectacle values (2, 'Tartuffe', 120, 30, 25);















-- Début Session 1
BEGIN TRANSACTION ISOLATION LEVEL read committed;
-- BEGIN TRANSACTION ISOLATION LEVEL repeatable read ;
-- BEGIN TRANSACTION ISOLATION LEVEL serializable;

SELECT * FROM Spectacle;

SELECT * FROM Client;
-- Interruption Session 1 ==> Allez en session 2



/* Début Session 2
BEGIN TRANSACTION ISOLATION LEVEL read committed;
BEGIN TRANSACTION ISOLATION LEVEL repeatable read;
BEGIN TRANSACTION ISOLATION LEVEL serializable;

SELECT * FROM Spectacle;

SELECT * FROM Client;



UPDATE Spectacle
	SET nb_places_libres=(SELECT nb_places_libres-2 FROM Spectacle WHERE titre='Ben hur')
		WHERE titre='Ben hur';

UPDATE Client
	SET nb_places_reservees=(SELECT nb_places_reservees+2 FROM Client WHERE nom='Julie'),
		solde=(SELECT solde-(SELECT tarif*2 FROM Spectacle WHERE titre='Ben hur') FROM Client WHERE nom='Julie')
		WHERE nom='Julie';

COMMIT TRANSACTION;

SELECT * FROM Spectacle;

SELECT * FROM Client;
Fin Session 2 ==> Allez en session 1*/



-- Reprise Session 1
SELECT * FROM Spectacle;

SELECT * FROM Client;

UPDATE Spectacle
	SET nb_places_libres=(SELECT nb_places_libres-5 FROM Spectacle WHERE titre='Ben hur')
		WHERE titre='Ben hur';

UPDATE Client
	SET nb_places_reservees=(SELECT nb_places_reservees+5 FROM Client WHERE nom='Philippe'),
		solde=(SELECT solde-(SELECT tarif*5 FROM Spectacle WHERE titre='Ben hur') FROM Client WHERE nom='Philippe')
		WHERE nom='Philippe';

COMMIT TRANSACTION;

SELECT * FROM Spectacle;

SELECT * FROM Client;
-- Fin Session 1


