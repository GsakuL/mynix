{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # sohamkamani.code-eol
      tamasfe.even-better-toml
      eamodio.gitlens
      jnoortheen.nix-ide
      mkhl.direnv

      ms-python.python
      ms-python.vscode-pylance
      ms-python.debugpy
      wholroyd.jinja
    ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
