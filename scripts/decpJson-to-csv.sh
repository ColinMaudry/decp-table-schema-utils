#!/usr/bin/env bash

dir=`dirname "$0"`

json=$1

#head -n 1 $dir/../exemples/exemple-valide.csv
echo "id,rootId,seq,uid,acheteur.id,acheteur.nom,nature,objet,codeCPV,procedure,lieuExecution.code,lieuExecution.typeCode,lieuExecution.nom,dureeMois,dateNotification,datePublicationDonnees,montant,formePrix,titulaire.id,titulaire.typeIdentifiant,titulaire.denominationSociale,objetModification,donneesActuelles,anomalies" > json.csv

jq -f $dir/detect-anomalies.jq $json | jq -f $dir/decp-to-csv.jq  | jq -r '@csv' >> json.csv
