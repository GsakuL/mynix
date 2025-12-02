{
  pkgs,
  lib,
  config,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = lib.mkForce false;
  };

  environment.systemPackages = lib.optionals config.virtualisation.docker.enable (
    with pkgs;
    [
      distrobox
      docker-compose

      dive
      docker-slim
    ]
  );
}
