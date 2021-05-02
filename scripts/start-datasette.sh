#!/usr/bin/env bash
ls -l

if [[ ! -d decp ]]
then
    mkdir decp
fi

rm -f decp/datapackage.json decp/decp.db

echo "Get data and make SQLite db..."
python3 scripts/datapackage-to-datasette.py

echo "Starting datasette..."
datasette decp/decp.db --template-dir datasette/templates --static static:datasette/static/ --metadata datasette/datasette.json  --plugins-dir datasette/plugins --port 9090
