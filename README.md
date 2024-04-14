# DECP Table Schema utils

⚠️ Ce dépôt est remplacé par un projet un peu plus vaste, [decp-processing](https://github.com/ColinMaudry/decp-processing)

> Version 1.3.4

Ce dépôt rassemble les outils liés au schéma tabulaire des DECP.

Il rassemble les outils suivants :

- `scripts/flow.py` : un script de conversion des données depuis le format JSON réglementaire vers le format tabulaire
- `scripts/make-decp-titulaires.sh`: un script de fusion des DECP avec certaines données du répertoire SIRENE pour produire [decp-titulaires.csv](https://www.data.gouv.fr/datasets/608c055b35eb4e6ee20eb325/#resource-25fcd9e6-ce5a-41a7-b6c0-f140abb2a060)
- `scripts/publish.sh`: un script de publication de l'ensemble des données produites [sur data.gouv.fr](https://www.data.gouv.fr/datasets/608c055b35eb4e6ee20eb325)

## JSON réglementaire vers CSV/SQLite

Pour transformer le JSON réglementaire en un fichier CSV et un fichier SQLite :

La commande suivante :

1. télécharge les données au format JSON réglementaire
1. détecte les anomalies dans le données
1. transforme les données au format CSV
1. rectifie le datatype de certaines colonnes
1. calcul la valeur de la colonne `donneesActuelles`
1. trie les données selon la colonne `datePublicationDonnees`
1. produit les fichiers suivants :
  - `./decp/decp.csv`
  - `./decp/datapackage.json`
  - `./decp/decp.sqlite`

Préparez votre environnement Python :

```shell
pipenv install
pipenv shell
```

Puis lancez la conversion :

```shell
python3 ./scripts/flow.py
```


## Notes de version

### 1.3.4 (16/11/2022)

- correction de dates malformées dans les données PES Marché (DGFiP)

### 1.3.3 (27/09/2021)

- correction et amélioration du filtrage par date de notification

### 1.3.2 (19/09/2021)

- filtrage des dates de notification trop mal formées

### 1.3.1 (05/09/2021)

- correction des dates qui commencent par "220-" au lieu de "2020-" (uid : `200060010000852020-02B457-L200`)

### 1.3.0 (03/06/2021)

- ne garder que les inscrits au SIRENE dans decp-titulaires ([f8c8bf4](https://github.com/ColinMaudry/decp-table-schema-utils/commit/f8c8bf4de76f5a11e89276f1e66db38912f8dcfe))
- correction de bugs:
  - suppression de la colonne `titulaire.typeIdentifiant` dans decp-sans-titulaires


### 1.2.0 (28/05/2021)

- déplacement du code de decp.info vers [ColinMaudry/decp.info](https://github.com/ColinMaudry/decp.info)
- remplacement du fichier `.sqlite.gz` par `.sqlite` 

### 1.1.0 (25/05/2021)

- ajout de nouvelles vues :
  - vue dédiée aux titulaires de marchés (`decp-titulaires`) avec données provenant du répertoire SIRENE
  - vue sans les titulaires (`decp-sans-titulaires`) pour analyser les nombres de marchés et les montants
- amélioration de la page d'accueil
- développement de la page "db" avec description des vues et liste des colonnes
- les codes APE sont cliquables
- ajout des mentions légales
- ajout d'un formulatire d'inscription à une lettre d'information
- correction de bugs :
  - correction du format de certaines dates dans les données

### 1.0.0

- publication sur https://decp.info
- ajout d'une vue équivalente au format DECP réglementaire
- personnalisation de datasette
- script de conversion quotidien basé sur [dataflows](https://github.com/datahq/dataflows)
