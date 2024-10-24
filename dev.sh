#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

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
while true
do
  sleep 2
  bash "$(pwd)/build_svelte.sh"
done
