/*
* Schéma de la base "Immeubles" - Cf. http://sql.bdpedia.fr
* 
* create database Immeubles;
* grant select on Immeubles.* to lecteur identified by 'mdpLecteur'
*/

create table immeuble(
	id integer not null,
	nom varchar(100) not null,
	adresse varchar(255) not null,
	primary key (id) 
);

create table appart(
	id integer not null,
	no integer not null,
	surface integer not null,
	niveau integer not null,
	idimmeuble integer not null,
	primary key (id), 
	
	foreign key (idimmeuble) references immeuble(id), 
	unique (idimmeuble, no)
);

create table personne(
	id serial not null,
	prenom varchar(50),
	nom varchar(50) not null,
	profession varchar(50),
	idappart integer,
	primary key (id),
	foreign key (idappart) references appart(id)
);

create table proprietaire(
	idpersonne integer not null,
	idappart integer not null,
	quotepart integer not null,
	primary key (idpersonne, idappart),
	foreign key (idpersonne) references personne(id),
	foreign key (idappart) references appart(id)
);
