/*
* Données de la base immeuble - - Cf. http://sql.bdpedia.fr
*/

insert into immeuble(id, nom, adresse)
		values(1, 'Koudalou', '3, rue des Martyrs');
insert into immeuble(id, nom, adresse)
	values(2, 'Barabas', '2, allée du Grand Turc');

insert into appart(id, no, surface, niveau, idimmeuble)
	values(100, 1, 150, 14, 1);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(101, 34, 50, 15, 1);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(102, 51, 200, 2, 1);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(103, 52, 50, 5, 1);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(104, 43, 75, 3, 1);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(200, 10, 150, 0, 2);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(201, 1, 250, 1, 2);
insert into appart(id, no, surface, niveau, idimmeuble)
	values(202, 2, 250, 2, 2);

insert into personne(id, prenom, nom, profession, idappart)
	values(1, NULL, 'Prof', 'Enseignant', 202);
insert into personne(id, prenom, nom, profession, idappart)
	values(2, 'Alice', 'Grincheux', 'Cadre', 103);
insert into personne(id, prenom, nom, profession, idappart)
	values(3, 'Léonie', 'Atchoum', 'Stagiaire', 100);
insert into personne(id, prenom, nom, profession, idappart)
	values(4, 'Barnabé', 'Simplet', 'Acteur', 102);
insert into personne(id, prenom, nom, profession, idappart)
	values(5, 'Alphonsine', 'Joyeux', 'Rentier', 201);
insert into personne(id, prenom, nom, profession, idappart)
	values(6, 'Brandon', 'Timide', 'Rentier', 104);
insert into personne(id, prenom, nom, profession, idappart)
	values(7, 'Don-Jean', 'Dormeur', 'Musicien', 200);

insert into proprietaire(idpersonne, idappart, quotePart)
	values(1, 100, 33);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(5, 100, 67);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(1, 101, 100);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(5, 102, 100);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(1, 202, 100);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(5, 201, 100);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(2, 103, 100);
insert into proprietaire(idpersonne, idappart, quotePart)
	values(2, 104, 100);
