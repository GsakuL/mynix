#!/usr/bin/env bash
set -e
pushd ~/mynix

nixfmt --check .

sudo nixos-rebuild switch --flake .

pushd ./modules/home/programs/firefox
./export.sh
popd

gen="$(./latest_gen.sh | sed -e s/-link$// | tr '\n' ' ' | xargs)"
echo "$gen"
git commit -am "$gen"
popd