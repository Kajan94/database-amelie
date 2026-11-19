-- Structure extraite de dabase.db, sans les données.
-- À exécuter dans une nouvelle base SQLite vide.
PRAGMA foreign_keys = ON;

CREATE TABLE Regions (
	Id_Region INTEGER NOT NULL,
	libelle_region TEXT NOT NULL,
	CONSTRAINT Id_Region PRIMARY KEY (Id_Region)
);

CREATE TABLE ProfessionsSante (
	Profession_sante TEXT NOT NULL,
	CONSTRAINT Profession_sante PRIMARY KEY (Profession_sante)
);

CREATE TABLE Departements (
	Num_Departement ANY NOT NULL,
	Id_Region INTEGER NOT NULL,
	libelle_departement TEXT NOT NULL,
	CONSTRAINT Id_Departement PRIMARY KEY (Num_Departement),
	CONSTRAINT Departements_Regions_FK FOREIGN KEY (Id_Region) REFERENCES Regions(Id_Region)
);

CREATE TABLE Demographie (
	Id_Demographie INTEGER NOT NULL,
	Annee INTEGER NOT NULL,
	Id_Region INTEGER NOT NULL,
	Num_Departement ANY NOT NULL,
	Profession_sante TEXT NOT NULL,
	type_exercice_liberal INTEGER NOT NULL,
	libelle_type_exercice_liberal VARCHAR NOT NULL,
	effectif INTEGER NOT NULL,
	CONSTRAINT Id_Demographie PRIMARY KEY (Id_Demographie),
	CONSTRAINT Demographie_Departements_FK FOREIGN KEY (Num_Departement) REFERENCES Departements(Num_Departement),
	CONSTRAINT Demographie_ProfessionsSante_FK FOREIGN KEY (Profession_sante) REFERENCES ProfessionsSante(Profession_sante),
	CONSTRAINT Demographie_Region_FK FOREIGN KEY (Id_Region) REFERENCES Regions(Id_Region)
);

CREATE TABLE Honoraires (
	Id_Honoraire INTEGER NOT NULL,
	Annee INTEGER NOT NULL,
	Profession_sante TEXT NOT NULL,
	Id_Region INTEGER NOT NULL,
	Num_Departement ANY NOT NULL,
	Honoraires_ordre_niv_1 INTEGER NOT NULL,
	type_honoraires_niveau_1 VARCHAR NOT NULL,
	Honoraires_ordre_niv_2 INTEGER NOT NULL,
	type_honoraires_niveau_2 VARCHAR,
	Honoraires_ordre_niv_3 INTEGER NOT NULL,
	type_honoraires_niveau_3 VARCHAR,
	Montant_honoraires REAL,
	Montant_honoraires_moyen REAL,
	CONSTRAINT Id_Honoraires PRIMARY KEY (Id_Honoraire),
	CONSTRAINT Honoraires_Departements_FK FOREIGN KEY (Num_Departement) REFERENCES Departements(Num_Departement),
	CONSTRAINT Honoraires_ProfessionsSante_FK FOREIGN KEY (Profession_sante) REFERENCES ProfessionsSante(Profession_sante),
	CONSTRAINT Honoraires_Region_FK FOREIGN KEY (Id_Region) REFERENCES Regions(Id_Region)
);

CREATE TABLE Prescriptions (
	Id_Prescription INTEGER NOT NULL,
	Annee INTEGER NOT NULL,
	Profession_sante TEXT NOT NULL,
	Num_Departement ANY NOT NULL,
	libelle_poste_prescription TEXT NOT NULL,
	poste_prescription ANY NOT NULL,
	montant_moyen_prescription ANY NOT NULL,
	montant_total_prescription ANY NOT NULL,
	montant_moyen_prescription_integer INTEGER,
	montant_total_prescription_integer INTEGER,
	Id_Region INT,
	CONSTRAINT Id_Prescription PRIMARY KEY (Id_Prescription),
	CONSTRAINT Prescriptions_Departements_FK FOREIGN KEY (Num_Departement) REFERENCES Departements(Num_Departement),
	CONSTRAINT Prescriptions_ProfessionsSante_FK FOREIGN KEY (Profession_sante) REFERENCES ProfessionsSante(Profession_sante),
	CONSTRAINT Prescriptions_Regions_FK FOREIGN KEY (Id_Region) REFERENCES Regions(Id_Region)
);
