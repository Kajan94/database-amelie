# Data Ameli · Base relationnelle SQLite

Ce dépôt présente la partie modélisation d’un projet universitaire réalisé en équipe. La base regroupe des données agrégées sur les prescriptions, les honoraires et la démographie des professions de santé, reliées à des référentiels géographiques.

[Rapport de conception](Rapport.pdf) · [Application web d’exploration](https://github.com/Kajan94/site-amelie)

## De la base à l’application

Ce dépôt fournit le modèle relationnel, le rapport et des requêtes d’exploration. L’application Flask utilise un petit extrait SQLite au démarrage et peut également charger la base complète selon les instructions de son propre README.

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

Les résultats ci-dessus correspondent au fichier versionné dans ce dépôt. [Source des données : Cnam, Data ameli](https://data.ameli.fr/)

[Projet dans le portfolio](https://kajan94.github.io/Portefolio/#ameli)
