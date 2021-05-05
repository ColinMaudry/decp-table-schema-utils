#!/usr/bin/env python3

import requests
import gzip
import shutil

if __name__ == '__main__':

    print("Téléchargement de decp.sqlite.gz...")
    sqlitegz = requests.get('https://www.data.gouv.fr/fr/datasets/r/c6b08d03-7aa4-4132-b5b2-fd76633feecc', allow_redirects=True)

    with open("datasette/db.db.gz", 'wb') as sqlitegzfile:
        sqlitegzfile.write(sqlitegz.content)

    with gzip.open('datasette/db.db.gz', 'rb') as sqlitegz,\
        open('datasette/db.db', 'wb') as sqlite:
            shutil.copyfileobj(sqlitegz, sqlite)
