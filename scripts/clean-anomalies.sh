#!/usr/bin/env bash

# Ce script prend des données au format JSON réglementaire et marque les marchés comportant des anomalies avec un array .anomalies.

json="$1"

dir=`dirname "$0"`

jq -f $dir/clean-anomalies.jq "$json"
