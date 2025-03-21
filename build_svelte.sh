#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

NEW_CHANGES='0.03'  # 3sec; you may need to increase it if your build takes longer than
BASE="$(pwd)/app/"

function check_src_changes() {
  recent_changes="$(find "${BASE}/svelte/src/" -type f -mmin -${NEW_CHANGES} | wc -l)"
  if [[ "$recent_changes" == '0' ]]
  then
    exit 0
  fi
}

check_src_changes

cd "${BASE}/svelte/"

npm run build >/dev/null

cd "$BASE"
DST_DIR="${BASE}/static/dist_dev"
mkdir -p "$DST_DIR"

APPS=$(ls "${BASE}/svelte/dist/"*.js | rev | cut -d '/' -f 1 | rev | cut -d '-' -f1)

for app in $APPS
do
  cp "${BASE}/svelte/dist/${app}"-*css "${DST_DIR}/${app}.css" 2>/dev/null || true
  cp "${BASE}/svelte/dist/${app}"-*js "${DST_DIR}/${app}.js" 2>/dev/null || true

  for reference in $APPS
  do
    if [[ "$app" != "$reference" ]]
    then
      if [ -f "${DST_DIR}/${app}.js" ]
      then
        sed -i "s|from\"./${reference}-[^\.]*\.js\"|from\"./${reference}.js\"|g" "${DST_DIR}/${app}.js"
        sed -i "s|import\"./${reference}-[^\.]*\.js\"|import\"./${reference}.js\"|g" "${DST_DIR}/${app}.js"
      fi
    fi
  done
done
echo "--- $(date +%H:%M:%S) UPDATED ---"
