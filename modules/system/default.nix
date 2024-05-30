{ pkgs, ... }:

{
  imports = [
    ./hardware/seifenkiste

    ./bluetooth.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./peripherals.nix
    ./sound.nix
  ];

  environment.systemPackages = with pkgs; [ usbutils ];
}
