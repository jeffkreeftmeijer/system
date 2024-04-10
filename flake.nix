{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
    };
    configuration = {
      users.users.jeff.home = "/Users/jeff";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.emacs
        ];

      services.emacs.enable = true;

      homebrew = {
        enable = true;

        onActivation = {
          cleanup = "zap";
        };

        casks = [
          "slack"
          "zoom"
          "docker"
          "spotify"
          "whatsapp"
        ];

        masApps = {
          "wireguard" = 1451685025;
          "adblock plus for safari" = 1432731683;
        };
      };

      environment.variables.EDITOR = "vim";

      system = {
        defaults = {
          NSGlobalDomain = {
            AppleShowAllFiles = true; # Show hidden files in Finder
            AppleShowAllExtensions = true; # Show file extensions in Finder
            "com.apple.sound.beep.volume" = 0.000;
            InitialKeyRepeat = 15;
            KeyRepeat = 2;
          };
          dock = {
            appswitcher-all-displays = true; # Show the app switcher on all displays
            autohide = true; # Automatically hide the dock
            autohide-delay = 0.0; # ... immediately
            autohide-time-modifier = 0.0; # ... and instantly
            launchanim = false; # No launch animations
            static-only = true; # Only show open apps in the Dock
            tilesize = 64; # Reset the Dock icon size to 64
          };
        };
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };
      };

      imports = [
        ./fonts.nix
        ./wallpaper
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = system;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # install homebrew under the default prefix
            enable = true;

            # apple silicon only: also install homebrew under the default intel prefix for rosetta 2
            enableRosetta = true;

            # user owning the homebrew prefix
            user = "jeff";

            # declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };

            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
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

            imports = [
            ];

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
        ./modules/atuin.nix
        ./modules/coreutils.nix
        ./modules/zsh.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
