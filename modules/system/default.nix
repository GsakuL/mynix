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

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true;
  };

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
