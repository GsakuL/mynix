{ pkgs, ... }:

{
  imports = [
    ./hardware/seifenkiste

    ./bluetooth.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./peripherals.nix
    ./sound
  ];

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true;
  };

  environment.systemPackages = with pkgs; [ usbutils ];
}
