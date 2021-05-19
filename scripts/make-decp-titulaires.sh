#!/usr/bin/env bash

# Téléchargement SIRET

# curl -sL http://data.cquest.org/geo_sirene/v2019/last/StockEtablissement_utf8_geo.csv.gz | gzip -d  > StockEtablissement_utf8_geo.csv &
#
# # Téléchargement SIREN
#
# curl -sL https://www.data.gouv.fr/fr/datasets/r/002899bc-214b-452d-bbe0-d07c413762b2 -o StockUniteLegale.zip
# unzip StockUniteLegale.zip
#
# wait


echo "Selection des colonnes du fichier SIRET..."

echo "siret,siren,longitude,latitude,codeAPE,etatEtablissement,departement" > siret-selection.csv

xsv select siret,siren,longitude,latitude,activitePrincipaleEtablissement,codeCommuneEtablissement StockEtablissement_utf8_geo.csv | tail -n +2 | sed -E 's/([0-9][0-9])[0-9][0-9][0-9]$/\1/' >> siret-selection.csv &

xsv select siret,etatAdministratifEtablissement StockEtablissement_utf8_geo.csv | sed 's/A$/Actif/' | sed 's/F$/Fermé/' > etatEtablissement.csv &

echo "Selection des colonnes du fichier SIREN..."

echo "siren,categorie" > siren-selection.csv

xsv select siren,categorieEntreprise StockUniteLegale_utf8.csv | tail -n +2 >> siren-selection.csv &

xsv select siren,etatAdministratifUniteLegale StockUniteLegale_utf8.csv | sed 's/A$/Active/' | sed 's/C$/Cessée/' > etatEntreprise.csv &

wait

echo "Récupération des libellés des categories juridiques..."

echo "siren,categorieJuridique" > cjEntreprise.csv

xsv select siren,categorieJuridiqueUniteLegale StockUniteLegale_utf8.csv | sed -E 's/([0-9][0-9])[0-9][0-9]$/\1/'  >> cjEntreprise.csv

xsv join --left categorieJuridique cjEntreprise.csv code cj.csv > cjEntreprise-libelle.csv

xsv join --left siren siren-selection.csv siren cjEntreprise-libelle.csv > siren-selection-cj.csv

echo "Fusion des données établissements et unités légale..."

xsv join --left siren siren-selection-cj.csv siren etatEntreprise.csv > siren-selection-etat-cj.csv &

xsv join --left siret siret-selection.csv siret etatEtablissement.csv > siret-selection-etat.csv &

wait

# rm siren-selection.csv siret-selection.csv etatEntreprise.csv etatEtablissement.csv


xsv join --left siren siret-selection-etat.csv siren siren-selection-etat-cj.csv | xsv select siret,codeAPE,departement,categorie,categorieJuridique,categorieJuridiqueLibelle1,categorieJuridiqueLibelle2,etatEtablissement,etatEntreprise,longitude,latitude > siren-siret.csv &

echo "Sélection des colonnes DECP..."

xsv select id,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,montant,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,donneesActuelles,anomalies decp/decp.csv | xsv search -s donneesActuelles "oui" > decp-selection.csv &

wait

echo "Fusion des DECP et des données SIRENE..."

xsv join --left "titulaire.id" decp-selection.csv "siret" siren-siret.csv > decp-titulaires.csv
