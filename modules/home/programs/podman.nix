{ pkgs, ... }:
{
  services.podman = {
    enable = true;
  };
  home.packages = with pkgs; [
    xorg.xauth
    xorg.xhost

    (lib.lowPrio pulseaudioFull)
  ];
}
