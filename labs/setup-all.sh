#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for lab_dir in "$SCRIPT_DIR"/[0-9]*/; do
    lab_name="$(basename "$lab_dir")"

    if [ ! -f "$lab_dir/setup.sh" ]; then
        echo "SKIP  $lab_name (kein setup.sh vorhanden)"
        continue
    fi

    echo "SETUP $lab_name ..."
    (cd "$lab_dir" && bash setup.sh)
    echo "OK    $lab_name"
    echo
done

echo "Alle Labs wurden aufgesetzt."
