{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    flake = builtins.toString ./../../..;
    clean = {
      enable = true;
      extraArgs = "--keep 10 --keep-since 2d --optimize";
    };
  };
  environment.systemPackages = with pkgs; [
    nvd # for nh
  ];
}
