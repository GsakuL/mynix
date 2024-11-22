{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    flake = ./../../..;
  };
  environment.systemPackages = with pkgs; [
    nvd # for nh
  ];
}
