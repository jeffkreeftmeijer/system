{
  description = "Jeff's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.flake-utils.follows = "flake-utils";
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
    jorgelbg = {
      url = "github:jorgelbg/homebrew-tap";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    configured-emacs = {
      url = "github:jeffkreeftmeijer/.emacs.d";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    darwinConfigurations = {
      macos = nix-darwin.lib.darwinSystem {

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
                "jorgelbg/homebrew-tap" = inputs.jorgelbg;
              };

              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.jeff = {
                home = {
                  username = "jeff";
                  homeDirectory = "/Users/jeff";
                  stateVersion = "23.11";
                };

                programs.emacs.package =
                  inputs.configured-emacs.packages.aarch64-darwin.configured-emacs;
              };

              sharedModules = [
                inputs.mac-app-util.homeManagerModules.default
              ];
            };
          }
          ./configuration.nix
          ./../../modules
          ./../../modules/darwin
          ./../../modules/alacritty.nix
        ];
      };
    };
  };
}
