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
      (with pkgs.vscode-extensions; [
        tamasfe.even-better-toml
        eamodio.gitlens
        jnoortheen.nix-ide
        mkhl.direnv

        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        wholroyd.jinja
        streetsidesoftware.code-spell-checker
      ])
      ++ (with from-marketplace; [
        medo64__render-crlf
        janisdd__vscode-edit-csv
        streetsidesoftware__code-spell-checker-german
      ]);
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
