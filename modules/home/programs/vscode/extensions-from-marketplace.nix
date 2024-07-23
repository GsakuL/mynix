{ pkgs, ... }:
let
  extDefToAttrs =
    def:
    builtins.map (e: {
      name = "${e.publisher}__${e.name}";
      value = pkgs.vscode-utils.extensionFromVscodeMarketplace e;
    }) def;

  mkExtensionList = (defs: builtins.listToAttrs (extDefToAttrs defs));
in
mkExtensionList [
  {
    # https://marketplace.visualstudio.com/items?itemName=sohamkamani.code-eol
    publisher = "sohamkamani";
    name = "code-eol";
    version = "0.3.3";
    sha256 = "sha256-XcDrzKQljET7X41Kc3ptQ2lNSD8whMvs70vwYTMpEwE=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=medo64.render-crlf
    publisher = "medo64";
    name = "render-crlf";
    version = "1.8.1";
    sha256 = "sha256-XBSTDC7YmnDppOqtH1xdJigTzfS2G0fAv5nh8wkp8tg=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv
    publisher = "janisdd";
    name = "vscode-edit-csv";
    version = "0.9.2";
    sha256 = "sha256-F/YEMrRlkLdIOATq+u6ovdZt21MgVbYH1PAnpyncFqs=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-german
    publisher = "streetsidesoftware";
    name = "code-spell-checker-german";
    version = "2.3.2";
    sha256 = "sha256-40Oc6ycNog9cxG4G5gCps2ADrM/wLuKWFrD4lnd91Z4=";
  }
]
