{
  system-config,
  lib,
  pkgs,
  ...
}:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    amdgpu_top

    bottles
    lutris
    protonup-qt
  ];

  home.sessionVariables = lib.optionalAttrs system-config.programs.steam.enable {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };
}
