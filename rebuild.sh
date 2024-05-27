#!/usr/bin/env bash
set -e
pushd ~/mynix

nixfmt .

sudo nixos-rebuild switch --flake .

gen_profile=$(readlink "$(readlink ~/.nix-profile)" |  sed 's/-link$//')
gen_system=$(readlink /nix/var/nix/profiles/system | sed 's/-link$//')

git commit -am "$gen_system $gen_profile"
popd