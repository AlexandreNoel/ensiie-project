------------------------------------
-- Suppression préventive des tables
------------------------------------
DROP TABLE IF EXISTS Annonce;
DROP TABLE IF EXISTS Vote;
DROP TABLE IF EXISTS NouveauProduit;
DROP TABLE IF EXISTS FaitPartieCommande;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS Barmen;
DROP TABLE IF EXISTS Categorie;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Credit;
DROP TABLE IF EXISTS Utilisateur;

------------------------------------
-- Création des rôles
------------------------------------

CREATE TABLE Utilisateur (
    idUtilisateur SERIAL PRIMARY KEY ,
    pseudo VARCHAR NOT NULL UNIQUE,
    prenom VARCHAR NOT NULL ,
    nom VARCHAR NOT NULL ,
    solde NUMERIC(19,2) NOT NULL
);

CREATE TABLE Barmen(
    idUtilisateur SERIAL PRIMARY KEY REFERENCES Utilisateur(idUtilisateur) ON DELETE CASCADE,
    Codebarmen VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Commande(
    idCommande SERIAL PRIMARY KEY,
    dateCommande TIMESTAMP default CURRENT_TIMESTAMP,
    idUtilisateur INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur),
    idBarmen INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur),
    prixTotal NUMERIC(19,2) NOT NULL
);

CREATE TABLE Categorie(
    idCategorie SERIAL PRIMARY KEY,
    libelle VARCHAR NOT NULL
);

CREATE TABLE Produit(
    idProduit SERIAL PRIMARY KEY,
    libelle VARCHAR NOT NULL,
    prix NUMERIC(19,2) NOT NULL,
    reduction NUMERIC(19,2) NOT NULL,
    quantiteStock INTEGER NOT NULL,
    estDisponible Bool NOT NULL,
    idCategorie INTEGER NOT NULL REFERENCES Categorie (idCategorie)
);

CREATE TABLE FaitPartieCommande(
    idProduit SERIAL NOT NULL REFERENCES Produit (idProduit),
    idCommande SERIAL NOT NULL REFERENCES Commande (idCommande),
    prixVente NUMERIC(19,2) NOT NULL,
    quantite INTEGER NOT NULL,
    PRIMARY KEY (idProduit, idCommande)
);


CREATE TABLE NouveauProduit(
    idNouveauProduit SERIAL PRIMARY KEY,
    libelle VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    idAuteur INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur)
);

CREATE TABLE Vote(
    idUtilisateur SERIAL NOT NULL REFERENCES Utilisateur  (idUtilisateur),
    idNouveauProduit SERIAL NOT NULL REFERENCES NouveauProduit (idNouveauProduit),
    dateVote TIMESTAMP default CURRENT_TIMESTAMP,
    PRIMARY KEY (idUtilisateur, IdNouveauProduit)
);

CREATE TABLE Annonce (
    idAnnonce SERIAL PRIMARY KEY,
    titre VARCHAR NOT NULL,
    contenu VARCHAR NOT NULL,
    idAuteur INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur),
    dateCreation date not null default CURRENT_DATE
);
CREATE TABLE Credit(
    idCredit SERIAL PRIMARY KEY,
    date date not null default CURRENT_DATE,
    montant FLOAT NOT NULL,
    idUtilisateur INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur),
    idBarmen INTEGER NOT NULL REFERENCES Utilisateur (idUtilisateur)
);


--------------------------------------------------
-- INSERTION DES DONNEES
--------------------------------------------------


-- Table Utilisateur
INSERT INTO Utilisateur(idUtilisateur,pseudo,  prenom,nom, solde ) VALUES (1,'GEFCLIC', 'Benoit','SCHOLL','25');
INSERT INTO Utilisateur(idUtilisateur,pseudo,  prenom,nom, solde ) VALUES (2,'CHAP','Antoine','CHAPUSOT','25');
INSERT INTO Utilisateur(idUtilisateur,pseudo,  prenom,nom, solde ) VALUES (3,'TOAST', 'Théo','PEUCKERT','25');

SELECT setval('utilisateur_idutilisateur_seq', 3, true);

--Table Barman
INSERT INTO Barmen(idUtilisateur,Codebarmen) VALUES(2,'admin');

-- Table Categorie
INSERT INTO Categorie(idCategorie,libelle) VALUES (1,'Boisson');
INSERT INTO Categorie(idCategorie,libelle) VALUES (2,'Friandise');
INSERT INTO Categorie(idCategorie,libelle) VALUES (3,'Snack');
INSERT INTO Categorie(idCategorie,libelle) VALUES (4,'Boissons Chaudes');

-- Table Produit
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Coca',0.50,0,4,TRUE,1);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Fanta',0.50,0,2,TRUE,1);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Sprite',0.50,0,5,TRUE,1);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Pizza ChouFleur',1.60,0,2,TRUE,3);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Buns Flageolet',1.50,0,2,TRUE,3);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Mars',0.50,0,2,TRUE,2);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Kinder Bueno',0.50,0,2,TRUE,2);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Cafe Fort',0.40,0,20,TRUE,4);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Cafe leger',0.40,0,20,TRUE,4);
INSERT INTO Produit(libelle,prix,reduction,quantiteStock,estDisponible,idCategorie) VALUES ('Thé',0.40,0,20,TRUE,4);

-- Table Annonce
INSERT INTO Annonce(titre,contenu,idAuteur,dateCreation) VALUES ('Nouvelle Application','<h1>Merci aux FIPAS </h1><br><p>Grace au travail acharnée des FIPAS, le BarC devient le BarD et vous porpose une toute nouvelle application de gestion de votre compte</p>',3,'01/01/2018');
INSERT INTO Annonce(titre,contenu,idAuteur,dateCreation) VALUES ('Nouvelle Application','<h1>Merci aux FIPAS </h1><br><p>Grace au travail acharnée des FIPAS, le BarC devient le BarD et vous porpose une toute nouvelle application de gestion de votre compte</p>',3,'01/01/2018');
INSERT INTO Annonce(titre,contenu,idAuteur,dateCreation) VALUES ('Nouvelle Application','<h1>Merci aux FIPAS </h1><br><p>Grace au travail acharnée des FIPAS, le BarC devient le BarD et vous porpose une toute nouvelle application de gestion de votre compte</p>',3,'01/01/2018');

-- Table NouveauProduit
INSERT INTO NouveauProduit(idNouveauProduit,libelle,Description,idAuteur) VALUES ('RedBull','Pour avoir des ailes en allant en cours',1);
-- Table Credit

INSERT INTO Credit(date,montant,idUtilisateur,idBarmen) VALUES ('2018-10-22',12,3,2);
INSERT INTO Credit(date,montant,idUtilisateur,idBarmen) VALUES ('2018-10-23',14,3,2);
INSERT INTO Credit(date,montant,idUtilisateur,idBarmen) VALUES ('2018-10-24',16,3,2);
INSERT INTO Credit(date,montant,idUtilisateur,idBarmen) VALUES ('2018-10-25',18,3,2);

-- Table Commande/FaitPartieCommande
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,1,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-27', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,2,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,2,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,2,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,3,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,3,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,3,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,4,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,4,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,4,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,5,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,5,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,6,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,7,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,8,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,8,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,9,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,9,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,9,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,10,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,10,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,11,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,12,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,13,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,13,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,14,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,14,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,15,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,16,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,16,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,17,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,17,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,18,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,19,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,20,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,20,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,20,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,21,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-12', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,22,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,22,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,22,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,23,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,24,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,25,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,26,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,26,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,27,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,28,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,28,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,29,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,30,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,30,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,31,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,32,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,32,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,33,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,33,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-27', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,34,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,34,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,35,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,35,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,35,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,36,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,37,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,37,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,38,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,39,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,39,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-22', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,40,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,40,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,41,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,41,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,42,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,42,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,43,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,44,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,44,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,44,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-01', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,45,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,46,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,47,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,48,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,48,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,49,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,49,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,50,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-01', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,51,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,52,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,52,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,52,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,53,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,54,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,54,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,54,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,55,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,55,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,56,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,57,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,58,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,59,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,59,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,59,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,60,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,60,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,60,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-22', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,61,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,62,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,62,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,62,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,63,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,64,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,64,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,64,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,65,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,65,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,66,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,67,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,67,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,67,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,68,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,69,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,69,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,70,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-01', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,71,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,71,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-25', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,72,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,72,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,73,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,74,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,74,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,75,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-22', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,76,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,76,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,77,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,77,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,78,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,78,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,78,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,79,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,79,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,79,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,80,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,80,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,80,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,81,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,81,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,82,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,82,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-12', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,83,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,84,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,84,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,84,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,85,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,85,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,86,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,87,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-01', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,88,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,89,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,90,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,90,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,90,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-25', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,91,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,91,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,91,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,92,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,92,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,92,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,93,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,93,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,94,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,94,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,94,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,95,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,96,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,97,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,97,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,97,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,98,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,99,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,100,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,100,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,101,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,101,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,102,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,103,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,103,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,103,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,104,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,104,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,104,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,105,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,105,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,106,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,107,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,107,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,107,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,108,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,108,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,108,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,109,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,109,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,109,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,110,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,110,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,111,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,112,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,112,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,113,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,113,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,113,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,114,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,114,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,114,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,115,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,115,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,115,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,116,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,117,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,117,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,118,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,118,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,119,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,119,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,119,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,120,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,120,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,121,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,122,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,122,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,123,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,123,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,124,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,125,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,125,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,126,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,126,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,127,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,128,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,128,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,129,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,129,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,130,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,130,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,131,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,132,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,132,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,132,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,133,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,133,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,134,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,134,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,134,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-25', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,135,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,135,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,136,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,136,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,136,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,137,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,137,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,138,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,139,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,140,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,140,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,141,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,141,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,141,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,142,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,143,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,143,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,143,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,144,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,144,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,144,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,145,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,145,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,146,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,146,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,147,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,148,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,148,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,148,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,149,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,149,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,150,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,150,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,151,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,151,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,152,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,153,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,153,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,153,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,154,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,155,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,155,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,156,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,156,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,156,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,157,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,157,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,158,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,158,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,158,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,159,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,159,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,159,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,160,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,161,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,161,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,162,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,162,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,163,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,164,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,164,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,165,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,166,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,167,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,167,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,167,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,168,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,168,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,168,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-12', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,169,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,169,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,169,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,170,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,171,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,171,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,172,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,172,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,172,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,173,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,173,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,173,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,174,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,175,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,175,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,175,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-06', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,176,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,176,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,176,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,177,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-20', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,178,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,178,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,179,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,179,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,180,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,180,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,180,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,181,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,181,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,181,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,182,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,182,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-22', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,183,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,183,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,183,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,184,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,184,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,184,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,185,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,185,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,185,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,186,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,186,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,187,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,187,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,187,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-12', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,188,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,188,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-01', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,189,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,189,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-08', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,190,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,190,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,191,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,192,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,192,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,192,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,193,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,193,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,193,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-27', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,194,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,194,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,194,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,195,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,195,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,196,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,196,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,196,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,197,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,198,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,198,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,198,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,199,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,200,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,200,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,201,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,201,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,202,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,202,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,203,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,204,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,204,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,204,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-25', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,205,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,205,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,206,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,206,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,206,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,207,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,207,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,207,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,208,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,208,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,208,4,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,209,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,209,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,209,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,210,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,210,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,210,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-19', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,211,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,211,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-13', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,212,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,212,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,212,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,213,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,213,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,214,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,214,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,214,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,215,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,216,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,217,3,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,218,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,219,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,219,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-14', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,220,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,220,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,220,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,221,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,221,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,221,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-16', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,222,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,222,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,222,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-01-12', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,223,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,224,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,225,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,226,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,226,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,226,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,227,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-26', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,228,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,228,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,229,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,229,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,229,4,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-05-28', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,230,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,230,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,230,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,231,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,231,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-21', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,232,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-07-27', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,233,4,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,233,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-03', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,234,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,234,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,234,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-04', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,235,4,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-04-25', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,236,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,236,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,236,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-07', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,237,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-23', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,238,3,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,238,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,238,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-17', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,239,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-08-11', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,240,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,240,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,240,3,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-10', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,241,3,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,241,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,241,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-10-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,242,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-24', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,243,3,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-06-05', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,244,0.5,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,244,4,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,244,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-02-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,245,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-03-15', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,246,0.5,1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (4,246,3,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,246,0.5,1);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-09-02', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,247,4,3);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,247,0.5,3);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-11-09', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,248,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (2,248,0.5,2);
INSERT INTO commande ( datecommande, idutilisateur, idbarmen, prixtotal) VALUES ('2018-12-18', 3, 2, 1);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (3,249,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (1,249,0.5,2);
INSERT INTO faitpartiecommande (idproduit, idcommande, prixvente, quantite) VALUES (5,249,4,3);
