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
    ./vscode.nix
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

      xwaylandvideobridge
      btop
      neofetch
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
    ])
    ++ lib.optional system-config.services.flatpak.enable pkgs.kdePackages.discover;
}
