{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
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
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      inherit pkgs;

      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "jeff";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
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

            targets.darwin.defaults = {
              "com.apple.Safari".IncludeDevelopMenu = true;
              "com.apple.Safari".ShowFullURLInSmartSearchField = true;
              "com.apple.Safari".AutoFillPasswords = true;
              "com.apple.iCal"."Show Week Numbers" = true;
            };

            programs.direnv.enable = true;

            programs.git.enable = true;
            programs.git.userName = "Jeff Kreeftmeijer";
            programs.git.userEmail = "jeff@kreeft.me";
            programs.git.signing.key = "0x90A581FD6D796692";
            programs.git.signing.signByDefault = true;
            programs.git.extraConfig.init.defaultBranch = "main";
            programs.git.extraConfig.github.user = "jeffkreeftmeijer";
            programs.git.ignores = [ "DS_Store" ];

            programs.bash.enable = true;

            programs.starship.enable = true;
            programs.starship.settings = {
              format = "$directory$git_branch$shell";
              add_newline = false;
              directory = {
                truncate_to_repo = false;
                style = "";
              };
              git_branch = {
                format = "[\\($branch(:$remote_branch)\\)]($style) ";
                style = "";
              };
              shell = {
                zsh_indicator = "%";
                bash_indicator = "\\$";
                disabled = false;
                style = "";
              };
            };
          };
        }
        ./configuration.nix
        ./fonts.nix
        ./wallpaper
        ./modules/adblock.nix
        ./modules/atuin.nix
        ./modules/coreutils.nix
        ./modules/docker.nix
        ./modules/emacs.nix
        ./modules/homebrew.nix
        ./modules/slack.nix
        ./modules/spotify.nix
        ./modules/whatsapp.nix
        ./modules/wireguard.nix
        ./modules/zoom.nix
        ./modules/zsh.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
