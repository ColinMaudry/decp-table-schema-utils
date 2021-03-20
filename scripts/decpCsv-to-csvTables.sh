#!/usr/bin/env bash

# Ce script produit des CSV adaptés au requêtage.

csv="$1"

if [[ ! -d csv ]]
then
    mkdir csv
fi

# Acheteurs

echo "Creation de acheteurs.csv..."

headersAcheteurs="acheteur.id,acheteur.nom"

xsv select $headersAcheteurs "$csv" | tail -n +2 | sort -u >> csv/acheteurs.csv

# time xsv join --left acheteur.id acheteurs.csv sirennic etablissements_sirets.csv | xsv select acheteur.id,rpet,depet,nomen_long,latitude,longitude,geo_score > temp
#
# while IFS=, read -r id,denominationSociale,nomen_long
# do
#     if [[  ]]
#     echo
# done < `xsv select acheteur.id, acheteur.denominationSociale,nomen_long, temp`

# Titulaires

echo "Creation de titulaires.csv..."

headersTitulaires="titulaire.id,titulaire.denominationSociale,titulaire.typeIdentifiant"

xsv select $headersTitulaires "$csv" | tail -n +2 | sort -u  > csv/titulaires.csv

# time xsv join --left titulaire.id titulaires.csv sirennic etablissements_sirets.csv | xsv select titulaire.id,rpet,depet,nomen_long,categorie,latitude,longitude,geo_score > temp
# mv temp titulaires.csv

# Contrats

echo "Creation de contrats.csv..."

headersContrats="uid,titulaire.id,donneesActuelles"

xsv select $headersContrats "$csv" | tail -n +2 | sort -u > csv/contrats.csv

echo "Creation de marches.csv..."

headersMarches="uid,id,acheteur.id,nature,objet,codeCPV,procedure,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,datePublicationDonnees,montant,formePrix,objetModification,donneesActuelles,anomalies"

xsv select "$headersMarches" "$csv" | tail -n +2 | grep ",$" | sort -u | sed "s/,,/,NULL,/g" | sed -E "s/[+-]0[0-9]\\:00//g"  > csv/marches.csv
