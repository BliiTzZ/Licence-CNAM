-- Scripts de création des tables

DROP TABLE IF EXISTS Spectacle;
DROP TABLE IF EXISTS Client;


CREATE TABLE Client(
	id_client INTEGER NOT NULL,
	nom VARCHAR(30) NOT NULl,
	nb_places_reservees INTEGER NOT NULL,
	solde INTEGER NOT NULL,
	PRIMARY KEY (id_client)
);

CREATE TABLE Spectacle(
	id_spectacle INTEGER NOT NULL,
	titre VARCHAR(30) NOT NULL,
	nb_places_offertes INTEGER NOT NULL,
	nb_places_libres INTEGER NOT NULL,
	tarif REAL NOT NULL,
	PRIMARY KEY (id_spectacle)
);










-- Etat initial de la base: 2 clients, un spectacle, 50 places libres
DELETE FROM Client;
DELETE FROM Spectacle;
INSERT INTO Client VALUES (1, 'Philippe', 0, 2000);
INSERT INTO Client VALUES (2, 'Julie', 0, 350);
INSERT INTO Spectacle VALUES (1, 'Ben hur', 250, 50, 15);
INSERT INTO Spectacle VALUES (2, 'Tartuffe', 120, 30, 25);












create or replace procedure Reservation (v_id_client INT, v_id_spectacle INT, nb_places INT)
language plpgsql
AS $$
-- Déclaration des variables
DECLARE
	v_client Client%ROWTYPE;
	v_spectacle Spectacle%ROWTYPE;
	v_places_libres INT;
	v_places_reservees INT;
BEGIN
	-- On recherche le spectacle
	SELECT * INTO v_spectacle
		FROM Spectacle WHERE id_spectacle=v_id_spectacle;

	-- S'il reste assez de places: on effectue la reservation
	IF (v_spectacle.nb_places_libres >= nb_places)
		THEN
			-- On recherche le client
			SELECT * INTO v_client FROM Client WHERE id_client=v_id_client;

			-- Calcul du transfert
			v_places_libres := v_spectacle.nb_places_libres - nb_places;
			v_places_reservees := v_client.nb_places_reservees + nb_places;

			-- On diminue le nombre de places libres
			UPDATE Spectacle SET nb_places_libres = v_places_libres
				WHERE id_spectacle=v_id_spectacle;

			-- On augmente le nombre de places reervees par le client
			UPDATE Client SET nb_places_reservees=v_places_reservees
				WHERE id_client = v_id_client;

			-- Validation
			commit;
		ELSE
			rollback;
		END IF;

END $$;




