#!/bin/bash


#**********************************************************************
#
# Publication des données agrégées dans un jeu de données sur data.gouv.fr
#**********************************************************************

# /!\ Le dataset doit avoir été créé et une ressource decp.json doit avoir été ajoutée
# à ce dataset.

# fail on error
set -e


export api="https://www.data.gouv.fr/api/1"
export dataset_id="608c055b35eb4e6ee20eb325"
export resource_id_decp="8587fe77-fb31-4155-8753-f6a3c5e0f5c9"
export resource_id_sans_titulaires="834c14dd-037c-4825-958d-0a841c4777ae"
export resource_id_datapackage="65194f6f-e273-4067-8075-56f072d56baf"
export resource_id_sqlite="c6b08d03-7aa4-4132-b5b2-fd76633feecc"


#API_KEY configurée dans les options de build de CircleCI
api_key=$API_KEY


if [[ ! -f ./decp/decp.csv ]]
then
    echo "Le fichier decp/decp.csv doit d'abord être généré."
    exit 1
fi

echo "Mise à jour de decp.csv..."

curl "$api/datasets/$dataset_id/resources/${resource_id_csv}/upload/" -F "file=@decp/decp.csv" -H "X-API-KEY: $api_key" | jq .

echo ""
echo "Mise à jour de decp-sans-titulaires.csv..."

curl "$api/datasets/$dataset_id/resources/${resource_id_sans_titulaires}/upload/" -F "file=@decp/decp-sans-titulaires.csv" -H "X-API-KEY: $api_key" | jq .

echo ""
echo "Mise à jour de datapackage.json..."

curl "$api/datasets/$dataset_id/resources/${resource_id_datapackage}/upload/" -F "file=@decp/datapackage.json" -H "X-API-KEY: $api_key" | jq .

echo ""
echo "Mise à jour de decp.sqlite..."

curl "$api/datasets/$dataset_id/resources/${resource_id_sqlite}/upload/" -F "file=@decp/decp.sqlite" -H "X-API-KEY: $api_key" | jq .
