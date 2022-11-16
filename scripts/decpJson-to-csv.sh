#!/usr/bin/env bash

set -e

json="decp.json"

dir=`dirname "$0"`

if [[ ! -f $json ]]
then
    echo "- Téléchargement des données depuis data.gouv.fr..."
    curl -sL "https://www.data.gouv.fr/fr/datasets/r/16962018-5c31-4296-9454-5998585496d2" -o $json
fi

if [[ ! -f decp-titulaires.csv ]]
then
    echo "- Téléchargement des données des titulaires..."
    curl -sL "https://www.data.gouv.fr/fr/datasets/r/25fcd9e6-ce5a-41a7-b6c0-f140abb2a060" -o decp-titulaires.csv
fi


#head -n 1 $dir/../exemples/exemple-valide.csv
echo "id,rootId,seq,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,procedure,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,datePublicationDonnees,montant,formePrix,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,objetModification,source,donneesActuelles,anomalies" > decp.csv

now=`date +"%Y-%m-%dT%H:%M:%SZ"`
echo "- Conversion JSON > CSV..."
jq -f $dir/detect-anomalies.jq $json | jq -f $dir/decp-to-csv.jq --arg now "$now"  | jq -r '@csv' >> decp.csv
