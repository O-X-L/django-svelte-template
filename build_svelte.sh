#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

BASE="$(pwd)/app/"

cd "${BASE}/svelte/index/"

npm run build >/dev/null

cd "$BASE"

cp "${BASE}/svelte/index/dist/"main-*css "${BASE}/static/dist/index.css"
cp "${BASE}/svelte/index/dist/"main-*js "${BASE}/static/dist/index.js"
