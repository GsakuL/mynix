{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  from-marketplace = import ./extensions-from-marketplace.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions =
      let
        p = pkgs.vscode-extensions;
        m = from-marketplace;
      in
      [
        # files / misc langs
        p.tamasfe.even-better-toml
        p.jnoortheen.nix-ide
        m.janisdd__vscode-edit-csv

        # utils
        p.eamodio.gitlens
        p.mkhl.direnv
        m.medo64__render-crlf

        # spelling
        p.streetsidesoftware.code-spell-checker
        m.streetsidesoftware__code-spell-checker-german

        # python
        p.ms-python.python
        p.ms-python.vscode-pylance
        p.ms-python.debugpy
        p.wholroyd.jinja
      ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
