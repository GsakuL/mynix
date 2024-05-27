{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
