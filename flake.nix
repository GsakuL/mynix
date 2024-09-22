{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable-old.url = "github:nixos/nixpkgs/d0e1602ddde669d5beb01aec49d71a51937ed7be";

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
      ...
    }@inputs:
    {
      nixosConfigurations = {
        seifenkiste =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              pkgs-alt = {
                stable = import nixpkgs-stable {
                  inherit system;
                  config.allowUnfree = true;
                };
                unstable-old = import nixpkgs-unstable-old {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
            };
            modules = [
              (
                { config, pkgs, ... }:
                {
                  nixpkgs.overlays = [
                    (import ./overlays/chromium-wallet.nix)
                    (import ./overlays/citrix-fixes.nix { inherit config; })
                    (import ./overlays/vesktop)
                  ];
                }
              )
              ./configuration.nix
            ];
          };
      };
    };
}
