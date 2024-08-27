{ pkgs, ... }:
let
  trim-gen-sh = (
    pkgs.fetchurl {
      url = "https://gist.githubusercontent.com/MaxwellDupre/3077cd229490cf93ecab08ef2a79c852/raw/ccb39ba6304ee836738d4ea62999f4451fbc27f7/trim-generations.sh";
      hash = "sha256-kIWTg8FSpNtDyEFr4/I54+GpGjiV2zWPO6WZQU4gEZ8=";
    }
  );
  trim-generations-bin = pkgs.writeShellScriptBin "trim-generations" ''
    source ${trim-gen-sh} "$@"
  '';
in
{
  imports = [
    ./hardware/seifenkiste

    ./bluetooth.nix
    ./docker.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./obs-studio.nix
    ./peripherals.nix
    ./scanner.nix
    ./sound
  ];

  services.flatpak.enable = true;

  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages =
    (with pkgs; [
      file
      tree
      bat
      nixfmt-rfc-style
      yj
      jq
      dos2unix

      usbutils
    ])
    ++ [

      (pkgs.python3.withPackages (pypkgs: with pypkgs; [ requests ]))
      trim-generations-bin
    ];
}
