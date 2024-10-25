{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable-old.url = "github:nixos/nixpkgs/2768c7d042a37de65bb1b5b3268fc987e534c49d";

    # allows to update this alone (but doesn't get left behind on full upgrade)
    nixpkgs-unstable-future.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
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
            importPkgs =
              p:
              import p {
                inherit system;
                config.allowUnfree = true;
                inherit overlays;
              };
            overlays = [
              (import ./overlays/chromium-wallet.nix)
              (import ./overlays/vesktop)
            ];
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              _tools = import ./modules/_tools;
              pkgs-alt = {
                stable = importPkgs nixpkgs-stable;
                unstable-old = importPkgs nixpkgs-unstable-old;
                unstable-future = importPkgs nixpkgs-unstable-future;
              };
            };
            modules = [
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
