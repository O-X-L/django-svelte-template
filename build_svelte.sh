#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

BASE="$(pwd)/app/"

cd "${BASE}/svelte/"

npm run build >/dev/null

cd "$BASE"
DST_DIR="${BASE}/static/dist_dev"
mkdir -p "$DST_DIR"

APPS=('index' 'main' 'test' 'legacy')

for app in "${APPS[@]}"
do
  cp "${BASE}/svelte/dist/${app}"-*css "${DST_DIR}/${app}.css" 2>/dev/null || true
  cp "${BASE}/svelte/dist/${app}"-*js "${DST_DIR}/${app}.js" 2>/dev/null || true

  for reference in "${APPS[@]}"
  do
    if [[ "$app" != "$reference" ]]
    then
      if [ -f "${DST_DIR}/${app}.js" ]
      then
        sed -i "s|from\"./${reference}-[^\.]*\.js\"|from\"./${reference}.js\"|g" "${DST_DIR}/${app}.js"
      fi
    fi
  done
done
echo "--- $(date +%H:%m:%S) UPDATED ---"
