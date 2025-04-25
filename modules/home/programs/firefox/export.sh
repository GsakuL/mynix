#!/usr/bin/env bash

mkdir -p .export

#p="$(nix eval --json --file 'policies.nix')"
#echo "$p" | jq '.defaultSettings|to_entries|map(["user_pref(", $q, .key, $q, ", ", $q, (.value|tostring), $q, ");"]|add) | join("\n") ' --arg q '"'  -r > .export/user.js;
#echo "$p" | jq ". | {policies: .defaultPolicies}" > .export/policies.json

#nix eval --file export.nix --apply 'f: f { settings = false; }' --raw > .export/policies.json
#nix eval --file export.nix --apply 'f: f { settings = true; }' --raw > .export/user.js

nix eval --file export.nix --apply 'f: f {  }' --raw > .export/user.js
sed -i '/"toolkit.legacyUserProfileCustomizations.stylesheets"/d' .export/user.js