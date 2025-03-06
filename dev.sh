#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

rm -f "$(pwd)/app/static/dist_dev/"*
rm -f '/tmp/.build_svelte_state.txt'

export DEV_MODE=1
export WEB_HOSTNAMES=localhost,127.0.0.1
export WEB_SECRET=secretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecret

trap 'kill $BGPID; exit' INT

echo '### Starting django ###'
source venv/bin/activate
python3 "$(pwd)/manage.py" runserver &
BGPID=$!

sleep 2

echo '### Running svelte updater.. ###'
touch "$(pwd)/app/svelte/src/.update_now"
while true
do
  bash "$(pwd)/build_svelte.sh"
done
