{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    configured-emacs = {
      url = "github:jeffkreeftmeijer/.emacs.d/asahi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, configured-emacs, ... }:
  let
    system = "aarch64-linux";
  in
  {
    nixosConfigurations = {
      asahi = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./../../modules/atuin.nix
          ./../../modules/emacs.nix
          ./../../modules/firefox.nix
          ./../../modules/fonts.nix
          ./../../modules/gdm.nix
          ./../../modules/git.nix
          ./../../modules/gnome.nix
          ./../../modules/gnumake.nix
          ./../../modules/gnupg.nix
          ./../../modules/home-manager.nix
          ./../../modules/pass.nix
          ./../../modules/starship.nix
          ./../../modules/vim.nix
          ./../../modules/zsh.nix
          ./../../modules/zsh-completions.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit configured-emacs system; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jeff = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
