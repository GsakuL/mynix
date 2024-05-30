{ pkgs, ... }:

{
  # keyboard
  hardware.wooting.enable = true;
  users.users.lukas.extraGroups = [ "input" ];

  # mouse
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    piper

    xorg.xev
    wev
  ];
}
