{ pkgs, ... }:

{
  imports = [
    ./hardware/seifenkiste

    ./bluetooth.nix
    ./docker.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./obs-studio.nix
    ./peripherals.nix
    ./sound
  ];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    file
    tree
    bat
    nixfmt-rfc-style
    yj
    jq

    usbutils
  ];
}
