#!/usr/bin/env bash

# Téléchargement SIRET

# curl -sL http://data.cquest.org/geo_sirene/v2019/last/StockEtablissementActif_utf8_geo.csv.gz | gzip -d  > StockEtablissementActif_utf8_geo.csv &
#
# # Téléchargement SIREN
#
# curl -sL https://www.data.gouv.fr/fr/datasets/r/002899bc-214b-452d-bbe0-d07c413762b2 -o StockUniteLegale.zip
# unzip StockUniteLegale.zip
#
# wait


echo "Selection des colonnes du fichier SIRET..."

echo "siret,siren,longitude,latitude,codeAPE,departement" > siret-selection.csv

xsv select siret,siren,longitude,latitude,activitePrincipaleEtablissement,codeCommuneEtablissement StockEtablissementActif_utf8_geo.csv | tail -n +2 | sed -E 's/([0-9][0-9])[0-9][0-9][0-9]$/\1/' >> siret-selection.csv &

echo "Selection des colonnes du fichier SIREN..."

echo "siren,categorie,categorieJuridique" > siren-selection.csv


xsv select siren,categorieEntreprise,categorieJuridiqueUniteLegale StockUniteLegale_utf8.csv | tail -n +2 >> siren-selection.csv

wait

echo "Fusion des données établissements et unités légale..."

xsv join --left siren siret-selection.csv siren siren-selection.csv | xsv select siret,codeAPE,departement,categorie,categorieJuridique,longitude,latitude > siren-siret.csv &

echo "Sélection des colonnes DECP..."

xsv select id,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,datePublicationDonnees,montant,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,donneesActuelles,anomalies decp/decp.csv | xsv search -s donneesActuelles "oui" > decp-selection.csv

echo "Fusion des DECP et des données SIRENE..."

xsv join --left "titulaire.id" decp-selection.csv "siret" siren-siret.csv > decp-titulaires.csv
