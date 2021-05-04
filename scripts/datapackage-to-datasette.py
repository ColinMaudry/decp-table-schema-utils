#!/usr/bin/env python3

from datapackage_to_datasette import datapackage_to_datasette, DataImportError
import requests

def load_to_sqlite() :
    try:
        datapackage_to_datasette(
            'datasette/db.db',
            'decp/datapackage.json',
            '/dev/null',
            write_mode='replace'
        )
    except DataImportError:
        raise

if __name__ == '__main__':

    print("Téléchargement de decp.csv...")
    csv = requests.get('https://www.data.gouv.fr/fr/datasets/r/8587fe77-fb31-4155-8753-f6a3c5e0f5c9', allow_redirects=True)
    with open("decp/decp.csv", 'w') as csvfile :
        csvfile.write(csv.content.decode('utf-8'))

    print("Téléchargement de datapackage.json...")
    datapackage = requests.get('https://www.data.gouv.fr/fr/datasets/r/65194f6f-e273-4067-8075-56f072d56baf', allow_redirects=True)
    with open("decp/datapackage.json", 'w') as datapackagefile :
        datapackagefile.write(datapackage.content.decode('utf-8'))

    print("Création de la base sqlite...")
    load_to_sqlite()
