#!/usr/bin/env bash
set -euo pipefail

# No registry dependency: this fixture installs a local package.
# Keep the initial setup mutable even when the test runner itself is in CI.
env -u CI devenv shell -- node -e 'if (require("local-dep") !== 42) process.exit(1)'
test -f node_modules/pnpm-lock.yaml.checksum

# A different store forces pnpm to recreate node_modules. Changing the lock
# checksum makes the automatic install run again on the next shell.
printf 'storeDir: "./second-store"\n' > pnpm-workspace.yaml
printf '\n# retry install from the new store\n' >> pnpm-lock.yaml
env -u CI devenv shell -- node -e 'if (require("local-dep") !== 42) process.exit(1)'
grep -q 'second-store' node_modules/.modules.yaml
