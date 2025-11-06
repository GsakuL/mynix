{
  pkgs,
  pkgs-alt,
  lib,
  ...
}:
{
  imports = [
    ./hardware/seifenkiste

    ./bluetooth.nix
    ./docker.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./nix-helpers
    ./obs-studio.nix
    ./peripherals.nix
    ./printer.nix
    ./scanner.nix
    ./sound
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };

  services.fwupd.enable = true;

  services.flatpak.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages =
    (with pkgs; [
      file
      tree
      bat
      nixfmt-rfc-style
      yj
      jq
      dos2unix

      pkgs-alt.unstable-very-old.trickle

      usbutils
    ])
    ++ [
      (pkgs.python3.withPackages (pypkgs: with pypkgs; [ requests ]))
    ];
}
