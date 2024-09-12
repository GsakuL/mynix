{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.seifenkiste = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
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
          # inputs.home-manager.nixosModules.default
        ];
      };
    };
}
