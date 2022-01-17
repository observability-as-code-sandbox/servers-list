#!/bin/bash

dt=$(date '+%Y-%m-%d_%H-%M-%S')

source_dir="./exported/"
source_file="servers.json"

destination_dir="./exported/"

$(cat ${source_dir}${source_file} | jq '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' | sed 's/\\"//g'> ${destination_dir}servers-${dt}.csv)