#!/usr/bin/env bash

# Ce script produit des CSV adaptés au requêtage.

csv="$1"

xsv select "acheteur.id,acheteur.nom" "$csv" > acheteurs.csv

xsv select "uid,id,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,donneesActuelles" "$csv" > contrats.csv


headersMarches="uid,id,acheteur.id,nature,objet,codeCPV,procedure,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,datePublicationDonnees,montant,formePrix,objetModification,donneesActuelles,anomalies"

echo "$headersMarches" > marches.csv

xsv select "$headersMarches" "$csv" | tail -n +2 | sort -u  >> marches.csv
