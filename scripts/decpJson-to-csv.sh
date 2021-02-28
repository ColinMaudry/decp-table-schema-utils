#!/usr/bin/env bash

dir=`dirname "$0"`

json=$1

jq -r -f $dir/decp-to-csv.jq $json
