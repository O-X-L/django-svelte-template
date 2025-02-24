#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

BASE="$(pwd)/app/"
STATE_FILE='/tmp/.build_svelte_state.txt'

function check_src_changes() {
  state="$(du -sb "${BASE}/svelte/src/")"
  if [ -f "$STATE_FILE" ]
  then
    if [[ "$(cat "$STATE_FILE")" == "$state" ]]
    then
      # no changes
      exit 0
    fi
  fi
  echo "$state" > "$STATE_FILE"
}

check_src_changes

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
echo "--- $(date +%H:%M:%S) UPDATED ---"
