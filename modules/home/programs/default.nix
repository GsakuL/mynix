{
  system-config,
  pkgs,
  lib,
  pkgs-alt,
  ...
}:

{
  imports = [
    ./arrpc
    ./btop
    ./firefox
    ./games.nix
    ./git.nix
    ./media
    ./terminals/kitty
    ./obs-studio.nix
    ./vesktop
    ./vscode
    ./shells/zsh
    ./work.nix
  ];

  services.caffeine.enable = lib.mkForce false;
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
    package = pkgs-alt.unstable-future.ungoogled-chromium;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    (with pkgs; [
      pkgs-alt.unstable-future.thunderbird
      pkgs-alt.unstable-future.signal-desktop
      pkgs-alt.unstable-future.telegram-desktop
      pkgs-alt.unstable-future.tor-browser

      keepassxc

      kdePackages.kruler

      kdePackages.kalgebra
      kdePackages.kcalc
      calc
      rink
      kalker

      kdePackages.xwaylandvideobridge
      fastfetch
      powershell

      kdePackages.kate
      krita
      gimp
      inkscape
      libreoffice
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      hunspellDicts.en_GB-ise

      p7zip
      pxz
      unzip
      unrar

      mqtt-explorer

      # kdePackages.plasma-applet-caffeine-plus
      # caffeine-ng

      (writeShellApplication {
        name = "caffeine";
        runtimeInputs = [ caffeine-ng ];
        text = ''
          exec caffeine "$@"
        '';
      })

      (writeShellApplication {
        name = "caffeine-loop";
        runtimeInputs = [ caffeine-ng ];
        text = ''
          while true; do
            caffeine "$@"
            echo "caffeine crash at: $(date --iso-8601=seconds)"
          done
        '';
      })

      openscad-unstable
      blender-hip
      freecad-wayland

      thonny

      appimage-run

      wtype
    ])
    ++ lib.optional system-config.services.flatpak.enable pkgs.kdePackages.discover;
}
