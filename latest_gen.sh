#!/usr/bin/env bash
set -e

readlink /nix/var/nix/profiles/system
readlink "$(readlink ~/.nix-profile)"
readlink "$(readlink ~/.nix-profile | sed -e s/profile$/home-manager/)"
