#!/usr/bin/env bash

rm -f decp/datapackage.json decp/decp.db

# Get data and make SQLite db
python3 scripts/datapackage-to-datasette.py

datasette decp/decp.db --template-dir datasette/templates --static static:datasette/static/ --metadata datasette/datasette.json  --plugins-dir datasette/plugins --port 9090
