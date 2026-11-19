# Data Ameli · Base de données SQLite

Ce projet consiste à structurer les données agrégées de l’Assurance Maladie dans une base relationnelle SQLite. Il rassemble les prescriptions, les honoraires et la démographie des professions de santé afin de les analyser par profession, territoire et année, sur la période **2010 à 2023**.

## Aperçu de la base

### Modèle relationnel

[![Modèle relationnel des six tables Data Ameli](modele-relationnel.svg)](modele-relationnel.svg)

Le modèle relie les référentiels géographiques et les professions de santé aux données de prescriptions, d’honoraires et de démographie. Il présente les six tables, leurs colonnes et leurs liens.

## Tester la base en local

Préparer **Git LFS** et un client SQLite, par exemple **DBeaver** ou **DB Browser for SQLite**.

```sh
git lfs install
git clone https://github.com/Kajan94/database-amelie.git
cd database-amelie
git lfs pull
```

Ouvrir ensuite `dabase.db` dans le client SQLite. La base complète fait environ **278 Mo**. Si le fichier ne contient que quelques lignes de texte, il s’agit du pointeur Git LFS : vérifier que `git lfs pull` a bien récupéré les données.

## Requêtes pour tester la base

Dans DBeaver ou DB Browser for SQLite, ouvrir un éditeur SQL relié à `dabase.db`, puis copier et exécuter les requêtes ci-dessous. Avec le client `sqlite3`, ouvrir la base en lecture seule :

```sh
sqlite3 -readonly -header -column dabase.db
```

### Voir les tables disponibles

```sql
SELECT name AS table_disponible
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;
```

La liste doit contenir `Regions`, `Departements`, `ProfessionsSante`, `Prescriptions`, `Honoraires` et `Demographie`.

### Vérifier les années des prescriptions

```sql
SELECT MIN(Annee) AS premiere_annee,
       MAX(Annee) AS derniere_annee
FROM Prescriptions;
```

Résultat attendu : **2010** et **2023**.

### Comparer les prescriptions par région en 2023

```sql
SELECT r.libelle_region AS region,
       p.montant_total_prescription_integer AS montant_euros
FROM Prescriptions AS p
JOIN Regions AS r ON r.Id_Region = p.Id_Region
WHERE p.Annee = 2023
  AND p.Num_Departement = 999
  AND p.Profession_sante = 'Ensemble des médecins'
  AND p.poste_prescription = 'total'
  AND r.Id_Region <> 99
  AND typeof(p.montant_total_prescription_integer) = 'integer'
ORDER BY montant_euros DESC;
```

Le classement présente **18 régions**, dont **7 814 970 581 €** pour l’Île-de-France. Les filtres choisissent un total régional pour un même périmètre de prescriptions.

### Consulter les effectifs en Île-de-France

```sql
SELECT Profession_sante,
       libelle_type_exercice_liberal AS mode_exercice,
       effectif
FROM Demographie
WHERE Id_Region = 11
  AND Num_Departement = 999
  AND Annee = 2023
  AND Profession_sante = 'Ensemble des médecins'
  AND typeof(effectif) = 'integer'
ORDER BY libelle_type_exercice_liberal;
```

Cette requête présente les effectifs régionaux par mode d’exercice. Les catégories peuvent se recouper ; elles ne doivent pas être additionnées sans vérifier leur périmètre.

## Conception et contenu

Les fichiers CSV de Data ameli ont été analysés puis intégrés dans SQLite avec DBeaver. Trois référentiels, `Regions`, `Departements` et `ProfessionsSante`, sont reliés aux tables de données par des clés étrangères :

- `Prescriptions` : postes et montants des prescriptions.
- `Honoraires` : catégories et montants d’honoraires.
- `Demographie` : effectifs par profession et mode d’exercice.

Chacune de ces trois tables couvre **2010 à 2023**. Les niveaux national, régional et départemental coexistent : les requêtes doivent choisir un périmètre précis pour éviter de compter plusieurs fois les mêmes agrégats.

La base SQLite complète est fournie dans `dabase.db` via Git LFS. Elle contient déjà les données : aucune création de tables ni import CSV n’est nécessaire pour l’explorer.

[Source des données Ameli](https://data.ameli.fr/)

## Travail en équipe

Projet universitaire réalisé à six en BUT Informatique à l’IUT de Créteil-Vitry (UPEC). J’ai assuré le rôle de chef de projet et participé à l’organisation et à la répartition du travail. L’équipe a travaillé sur l’analyse des fichiers sources, la modélisation relationnelle, l’intégration des données et les requêtes de vérification.
