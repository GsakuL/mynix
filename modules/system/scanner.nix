{ pkgs, pkgs-alt, ... }:

{
  environment.systemPackages = with pkgs; [
    epsonscan2
    epson-escpr

    kdePackages.skanlite
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  hardware.sane.enable = true;
  users.users."lukas".extraGroups = [
    "scanner"
    "lp"
  ];
}
