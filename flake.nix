{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable-old.url = "github:nixos/nixpkgs/5d67ea6b4b63378b9c13be21e2ec9d1afc921713";

    # allows to update this alone (but doesn't get left behind on full upgrade)
    nixpkgs-unstable-future.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat.url = "github:edolstra/flake-compat";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable-future";
        flake-utils.follows = "flake-utils";
      };
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable-future";
        flake-utils.follows = "flake-utils";
      };
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs-unstable-future";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable-old,
      nixpkgs-unstable-future,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        seifenkiste =
          let
            system = "x86_64-linux";
            importPkgs = p: importPkgsWithOverlays p [ ];
            importPkgsWithOverlays =
              p: o:
              import p {
                inherit system;
                config.allowUnfree = true;
                overlays = overlays ++ o;
              };
            overlays = [
              (import ./overlays/vesktop)
            ];
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit self inputs system;
              _tools = import ./modules/_tools;
              pkgs-alt = {
                stable = importPkgs nixpkgs-stable;
                unstable-old = importPkgs nixpkgs-unstable-old;
                unstable-future = importPkgsWithOverlays nixpkgs-unstable-future [
                  inputs.nix-vscode-extensions.overlays.default
                ];
              };
            };
            modules = [
              (
                { self, system, ... }:
                {
                  environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
                    nix-alien
                  ];
                  # Optional, needed for `nix-alien-ld`
                  programs.nix-ld.enable = true;
                }
              )
              (
                { config, pkgs, ... }:
                {
                  nixpkgs.overlays = overlays;
                }
              )
              ./configuration.nix
            ];
          };
      };
    };
}
