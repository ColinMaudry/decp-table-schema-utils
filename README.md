# DECP Table Schema utils

> Version 1.0.0

Ce dépôt rassemble les outils liés au schéma tabulaire des DECP.

Il rassemble principalement deux outils :

- un script de conversion des données depuis le format JSON réglementaire vers le format tabulaire
- des scripts de personnalisation et de configuration de datasette

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
  - `./datasette/decp.sqlite`

```
python3 ./scripts/flow.py
```

## Personnalisation et configuration de datasette

Les fichiers de personnalisation et configuration de datasette se trouvent dans le dossier `./datasette`.
