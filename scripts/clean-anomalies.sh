#!/usr/bin/env bash

json="$1"

dir=`dirname "$0"`

jq -f $dir/clean-anomalies.jq "$json"
