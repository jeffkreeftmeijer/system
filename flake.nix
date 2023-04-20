{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    configured-emacs = {
      url = "github:jeffkreeftmeijer/.emacs.d/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, configured-emacs, ... }:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ configured-emacs.overlay ];
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations."jeff-mbp" = darwin.lib.darwinSystem {
        inherit system;

        modules = [
          ./modules/nix-daemon.nix
        ];
      };

      homeConfigurations.jeffkreeftmeijer = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
  
        modules = [
          ./home.nix
        ];
      };
    };
}
