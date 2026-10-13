#!/usr/bin/env bash
set -euo pipefail

if devenv shell -- touch command-ran > install.stdout 2> install.stderr; then
  echo "shell startup succeeded after pnpm failed" >&2
  exit 1
fi
grep -q 'intentional pnpm install failure' install.stdout install.stderr
test ! -e after-install
test ! -e command-ran
test ! -e node_modules/pnpm-lock.yaml.checksum
