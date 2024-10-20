#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/"

if ! [ -f venv/bin/activate ]
then
  python3 -m virtualenv venv
fi

source venv/bin/activate
python3 -m pip install django

# see: https://github.com/nodesource/distributions
if ! which npm > /dev/null
then
  echo ''
  echo '### Installing NPM ###'
  curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
  sudo -E bash nodesource_setup.sh
  sudo apt-get install -y nodejs
fi

if ! [ -d app/svelte/node_modules/@sveltejs ]
then
  echo ''
  echo '### Installing Svelte ###'
  cd "$(pwd)/app/svelte"
  npm install
fi
