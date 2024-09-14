#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

echo '### Starting django ###'
source venv/bin/activate
python3 "$(pwd)/app/manage.py" runserver &

sleep 2

echo '### Running svelte updater.. ###'
while true
do
  sleep 2
  bash "$(pwd)/build_svelte.sh"
done