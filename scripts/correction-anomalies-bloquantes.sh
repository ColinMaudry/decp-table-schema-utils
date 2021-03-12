#!/usr/bin/env bash

json=$1


cat $json | \

# Suppression des doubles espaces et des retours à la ligne (\n)

sed -E "s/\\\n+/ /g" \
| sed -E "s/ +/ /g"
