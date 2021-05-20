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

echo "Extraction des SIRET des DECP..."

echo "titulaire.id,titulaire.typeIdentifiant" > decpSirets.csv
xsv select titulaire.id,titulaire.typeIdentifiant decp/decp.csv | tail -n +2 | grep "SIRET" | sort -u >> decpSirets.csv

echo "Récupération des données SIRET..."

xsv join --left titulaire.id decpSirets.csv siret StockEtablissement_utf8_geo.csv > decpSirets-full-etab.csv

echo "Récupération des données SIREN..."

xsv join --left siren decpSirets-full-etab.csv siren StockUniteLegale_utf8.csv > decpSirets-full.csv

echo "Selection des colonnes du fichier SIRET..."

echo "siret,siren,longitude,latitude,codeAPE,departement" > siret-selection.csv

xsv select siret,siren,longitude,latitude,activitePrincipaleEtablissement,codeCommuneEtablissement decpSirets-full.csv | tail -n +2 | sed -E 's/([0-9][0-9])[0-9][0-9][0-9]$/\1/' >> siret-selection.csv &

echo "siret,etatEtablissement" > etatEtablissement.csv
xsv select siret,etatAdministratifEtablissement decpSirets-full.csv | tail -n +2 | sed 's/A$/Actif/' | sed 's/F$/Fermé/' >> etatEtablissement.csv &

echo "Selection des colonnes du fichier SIREN..."

echo "siren,categorie" > siren-selection.csv
xsv select siren,categorieEntreprise decpSirets-full.csv  | tail -n +2 >> siren-selection.csv &

echo "Récupération et correction des données ESS et état du fichier SIREN..."

echo "siren,etatEntreprise,ESS" > etatEssEntreprise.csv
xsv select siren,etatAdministratifUniteLegale,economieSocialeSolidaireUniteLegale decpSirets-full.csv | tail -n +2 | sed 's/,A,/,Active,/' | sed 's/,C,/,Cessée,/' | sed 's/O$/oui/' | sed 's/N$/non/' >> etatEssEntreprise.csv &


echo "Récupération et raccourcissement des categories juridiques du fichier SIREN..."

echo "siren,categorieJuridique" > cjEntreprise.csv
xsv select siren,categorieJuridiqueUniteLegale decpSirets-full.csv | tail -n +2 | sed -E 's/([0-9][0-9])[0-9][0-9]$/\1/'  >> cjEntreprise.csv

wait

echo "Récupération des libellés des catégories juridiques..."

xsv join --left categorieJuridique cjEntreprise.csv code cj.csv > cjEntreprise-libelle.csv

echo "Fusion des données siren et des catégories juridiques..."

xsv cat columns siren-selection.csv cjEntreprise-libelle.csv > siren-selection-cj.csv

echo "Fusion des données siren+cj et etat+ess+entreprise..."

xsv cat columns siren-selection-cj.csv etatEssEntreprise.csv > siren-selection-etat-cj.csv &

echo "Fusion des données siret et etat..."

xsv cat columns siret-selection.csv etatEtablissement.csv > siret-selection-etat.csv &

wait

# rm siren-selection.csv siret-selection.csv etatEntreprise.csv etatEtablissement.csv

echo "Fusion des données siret et siren..."

xsv join --left siren siret-selection-etat.csv siren siren-selection-etat-cj.csv | xsv select siret,codeAPE,departement,categorie,categorieJuridique,categorieJuridiqueLibelle1,categorieJuridiqueLibelle2,etatEtablissement,etatEntreprise,longitude,latitude > siren-siret.csv &

echo "Sélection des colonnes DECP..."

xsv select id,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,montant,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,donneesActuelles,anomalies decp/decp.csv | xsv search -s donneesActuelles "oui" > decp-selection.csv &

wait

echo "Fusion des DECP et des données SIRENE..."

xsv join --left "titulaire.id" decp-selection.csv "siret" siren-siret.csv | xsv select id,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,montant,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,codeAPE,departement,categorie,categorieJuridique,categorieJuridiqueLibelle1,categorieJuridiqueLibelle2,etatEtablissement,etatEntreprise,longitude,latitude,donneesActuelles,anomalies > decp-titulaires.csv
