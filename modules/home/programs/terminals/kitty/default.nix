{
  inputs,
  pkgs,
  lib,
  ...
}:
let
in
{
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./extras.kitty.conf;
  };
}
