#!/usr/bin/env bash
set -euo pipefail

code --list-extensions | sort 1> >(tee extensions.txt)