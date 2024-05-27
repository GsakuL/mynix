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
    extensions = with pkgs.vscode-extensions; [
      # sohamkamani.code-eol
      eamodio.gitlens
      jnoortheen.nix-ide
      mkhl.direnv
    ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
