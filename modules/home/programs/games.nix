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

  home.packages = with pkgs; [
    amdgpu_top

    bottles
    lutris
    heroic
    protonup-qt
    wineWowPackages.waylandFull
  ];

  home.sessionVariables = lib.optionalAttrs system-config.programs.steam.enable {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };
}
