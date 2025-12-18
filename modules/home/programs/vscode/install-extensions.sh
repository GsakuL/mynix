#!/usr/bin/env bash
set -euo pipefail

for e in $(cat extensions.txt); do
    code --install-extension "$e"
done
