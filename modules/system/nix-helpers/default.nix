{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    flake = builtins.toString ./../../..;
  };
  environment.systemPackages = with pkgs; [
    nvd # for nh
  ];
}
