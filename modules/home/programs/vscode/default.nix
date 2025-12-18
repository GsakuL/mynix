{
  lib,
  pkgs,
  pkgs-alt,
  ...
}:

{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    package = (
      pkgs-alt.unstable-future.vscode.override { commandLineArgs = "--password-store=basic"; }
    );
    enable = true;
    mutableExtensionsDir = true;
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
