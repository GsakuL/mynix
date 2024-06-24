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
    publisher = "sohamkamani";
    name = "code-eol";
    version = "0.3.3";
    sha256 = "sha256-XcDrzKQljET7X41Kc3ptQ2lNSD8whMvs70vwYTMpEwE=";
  }
  {
    publisher = "medo64";
    name = "render-crlf";
    version = "1.8.1";
    sha256 = "sha256-XBSTDC7YmnDppOqtH1xdJigTzfS2G0fAv5nh8wkp8tg=";
  }
  {
    publisher = "janisdd";
    name = "vscode-edit-csv";
    version = "0.9.1";
    sha256 = "sha256-5Xc0X0acECR5Inmwg25gQZbdbSP6PJ+VF3oakNN/Syw=";
  }
]
