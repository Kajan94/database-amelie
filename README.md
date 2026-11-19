# Data Ameli · Base relationnelle SQLite

Ce dépôt présente la partie modélisation d’un projet universitaire réalisé en équipe. La base regroupe des données agrégées sur les prescriptions, les honoraires et la démographie des professions de santé, reliées à des référentiels géographiques.

[Application web d’exploration](https://github.com/Kajan94/site-amelie)

## De la base à l’application

Ce dépôt fournit le modèle relationnel, le rapport et des requêtes d’exploration. L’application Flask utilise un petit extrait SQLite au démarrage et peut également charger la base complète selon les instructions de son propre README.

## Conception de la base

Le travail a consisté à analyser trois familles de fichiers CSV de Data ameli, à définir leurs relations, puis à les intégrer dans SQLite avec DBeaver. Les tables `Regions`, `Departements` et `ProfessionsSante` servent de référentiels aux tables `Prescriptions`, `Honoraires` et `Demographie`.

Le fichier [schema.sql](schema.sql) permet de lire la structure des six tables, leurs clés primaires et leurs clés étrangères sans télécharger la base complète. Il reproduit la structure du fichier `dabase.db` et peut créer une base vide ; il ne contient ni les données ni un script d’import des CSV.

La base contient **390 960 lignes de prescriptions**, **1 182 720 lignes d’honoraires** et **123 840 lignes de démographie**, chacune de ces trois tables couvrant **2010 à 2023**. Les niveaux national, régional et départemental ainsi que les catégories de professionnels coexistent : il faut sélectionner un périmètre précis avant de calculer des totaux.

## Travail en équipe

Projet universitaire réalisé à six. J’ai assuré le rôle de chef de projet et participé à l’organisation et à la répartition du travail. Le rapport de conception présente la démarche, les choix de modélisation, des requêtes d’analyse et les membres de l’équipe.

## Ouvrir la base

`dabase.db` est stockée dans Git LFS. Installer [Git LFS](https://git-lfs.com/), puis cloner le dépôt. Le fichier complet fait **278 Mo**.

~~~sh
git lfs install
git clone https://github.com/Kajan94/database-amelie.git
cd database-amelie
git lfs pull
~~~

Ouvrir ensuite `dabase.db` avec SQLite ou DB Browser for SQLite. Le ZIP de code contient le pointeur Git LFS. Le clone et `git lfs pull` donnent accès au fichier complet.

## Requêtes à reproduire

Les trois requêtes [explorer.sql](explorer.sql) s’exécutent en lecture seule avec le client SQLite.

~~~sh
sqlite3 -readonly -header -column dabase.db ".read explorer.sql"
~~~

- La table `Prescriptions` contient **390 960 lignes** couvrant **2010 à 2023**.
- La jointure de contrôle identifie **une référence départementale sans région correspondante** dans la base complète.
- Le classement des totaux régionaux 2023 utilise le même périmètre pour chaque ligne. Il renvoie **18 régions**, avec **7 814 970 581 €** pour l’Île-de-France.

La référence sans région concerne le code départemental `999`, libellé « Tout département », associé au code région `999`, absent de `Regions`. Cette anomalie du fichier d’origine est conservée et signalée ; le contrôle d’intégrité SQLite retourne `ok`, mais le contrôle des clés étrangères signale cette ligne.

Les résultats ci-dessus correspondent au fichier versionné dans ce dépôt. [Source des données : Cnam, Data ameli](https://data.ameli.fr/)

[Projet dans le portfolio](https://kajan94.github.io/Portefolio/#ameli)
