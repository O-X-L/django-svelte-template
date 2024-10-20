#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

BASE="$(pwd)/app/"

cd "${BASE}/svelte/"

npm run build >/dev/null

cd "$BASE"

APPS=('main' 'test')

for app in "${APPS[@]}"
do
  cp "${BASE}/svelte/dist/${app}"-*css "${BASE}/static/dist/${app}.css" 2>/dev/null || true
  cp "${BASE}/svelte/dist/${app}"-*js "${BASE}/static/dist/${app}.js" 2>/dev/null || true
done
