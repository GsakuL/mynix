{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [ ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [

    ];
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
