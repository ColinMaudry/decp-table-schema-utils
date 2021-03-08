#!/usr/bin/env bash

dir=`dirname "$0"`

json=$1

head -n 1 $dir/../exemples/exemple-valide.csv

jq -f $dir/decp-to-csv.jq $json | jq -r '@csv'
