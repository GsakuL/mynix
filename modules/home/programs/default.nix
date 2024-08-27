{
  system-config,
  pkgs,
  lib,
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    (with pkgs; [
      thunderbird
      signal-desktop
      telegram-desktop
      discord
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

      openscad-unstable

      thonny
    ])
    ++ lib.optional system-config.services.flatpak.enable pkgs.kdePackages.discover;
}
