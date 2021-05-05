#!/usr/bin/env bash
ls -l

if [[ ! -d decp ]]
then
    mkdir decp
fi

echo "Get data..."
python3 scripts/datapackage-to-datasette.py

datasette inspect datasette/*.db --inspect-file=datasette/inspect-data.json

echo "Starting datasette..."
datasette datasette/ --port 9090 --cors | grep -v "/static/"
