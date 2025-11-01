#!/usr/bin/env bash
set -e

INPUT="./theme/colors.toml"
OUTPUT="./.dotter/colors_flat.toml"

echo "[default.variables]" > "$OUTPUT"

# Read all lines, skip headers ([...]), keep key=value lines
grep -v '^\[' "$INPUT" | while IFS= read -r line; do
    # Skip empty lines or comment-only lines
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    echo "$line" >> "$OUTPUT"
done

cat ./.dotter/colors_flat.toml

