{ pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    amdgpu_top

    bottles
    lutris
  ];
}
