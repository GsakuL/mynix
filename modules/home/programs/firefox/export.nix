{
  settings ? true,
  policiesAsSettings ? true,
}:

let
  pol = import ./policies.nix;

  policies_as_settings = builtins.mapAttrs (n: v: v.Value) pol.defaultPolicies.Preferences;

  toValue = (
    v:
    if v == true then
      "true"
    else if v == false then
      "false"
    else if (builtins.isString v) then
      "\"${v}\""
    else
      (builtins.toString v)
  );

  make_user_pref = (name: value: "user_pref(\"${name}\", ${value});");
  makeLine = (name: attrs: make_user_pref name (toValue (builtins.getAttr name attrs)));

  attrsToJsLines = (
    attrs:
    let
      names = builtins.attrNames attrs;
      mapped = builtins.map (n: (makeLine n attrs)) names;
    in
    mapped
  );

  attrsToJsLinesWithParrot = (
    name: attrs:
    [ (make_user_pref "_user.js.parrot" "\"START ${name}\"") ]
    ++ (attrsToJsLines attrs)
    ++ [
      (make_user_pref "_user.js.parrot" "\"END ${name}\"")
      ""
    ]
  );

  fromPolicies = attrsToJsLinesWithParrot "fromPolicies" policies_as_settings;
  fromSettings = attrsToJsLinesWithParrot "fromSettings" pol.defaultSettings;

  fromAll = fromSettings ++ (if policiesAsSettings then fromPolicies else [ ]);
  fromAllString = builtins.concatStringsSep "\n" fromAll;
in
if settings then fromAllString else (builtins.toJSON { policies = pol.defaultPolicies; })
