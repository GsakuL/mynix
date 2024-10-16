{
  system-config,
  pkgs,
  lib,
  pkgs-alt,
  ...
}:

{
  imports = [
    ./firefox
    ./games.nix
    ./git.nix
    ./media
    ./terminals/kitty
    ./obs-studio.nix
    ./vscode
    ./shells/zsh
    ./work.nix
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.poetry = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [ "--password-store=basic" ];
  };

  services.arrpc.enable = true; # vesktop

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    (with pkgs; [
      pkgs-alt.unstable-future.thunderbird
      pkgs-alt.unstable-future.signal-desktop
      pkgs-alt.unstable-future.telegram-desktop
      pkgs-alt.unstable-future.vesktop
      keepassxc

      kdePackages.kalgebra
      kdePackages.kcalc
      calc
      rink
      kalker

      xwaylandvideobridge
      btop
      fastfetch
      powershell

      kate
      krita
      libreoffice
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      hunspellDicts.en_GB-ise

      p7zip
      pxz

      plasma-applet-caffeine-plus
      caffeine-ng

      pkgs-alt.unstable-old.openscad-unstable

      thonny
    ])
    ++ lib.optional system-config.services.flatpak.enable pkgs.kdePackages.discover;
}
