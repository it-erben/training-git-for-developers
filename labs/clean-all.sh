#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for lab_dir in "$SCRIPT_DIR"/[0-9]*/; do
    lab_name="$(basename "$lab_dir")"
    exercise_dir="$lab_dir/exercise"

    if [ -d "$exercise_dir" ]; then
        rm -rf "$exercise_dir"
        echo "CLEAN $lab_name"
    fi
done

echo ""
echo "Alle exercise-Verzeichnisse wurden entfernt."
