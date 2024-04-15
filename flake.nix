{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    configured-emacs = {
      url = "github:jeffkreeftmeijer/.emacs.d/bankrupt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(final: prev: rec {
        emacs = inputs.configured-emacs.packages.${system}.configured-emacs;
      })];
      config.allowUnfree = true;
    };
  in
  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      inherit pkgs;

      modules = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "jeff";

            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
            };

            mutableTaps = false;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jeff = {
            home.username = "jeff";
            home.homeDirectory = "/Users/jeff";
            home.stateVersion = "23.11";

            programs.direnv.enable = true;
          };
        }
        ./configuration.nix
        ./wallpaper
        ./modules
      ];
    };
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jeff = {
            home.username = "jeff";
            home.homeDirectory = "/home/jeff";
            home.stateVersion = "23.11";
          };
        }
        ./machines/nixos/configuration.nix
      ];
    };
  };
}
