{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
    configured-emacs.url = "github:jeffkreeftmeijer/.emacs.d";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, configured-emacs }:
  let
    pkgs-with-overlay = import nixpkgs {
      system = "aarch64-darwin";
      overlays = [ configured-emacs.overlay ];
    };

    configuration = { pkgs, ... }: {
      users.users.jeff.home = "/Users/jeff";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs-with-overlay.configured-emacs
          pkgs.devenv
        ];

      services.emacs.enable = true;
      services.emacs.package = pkgs-with-overlay.configured-emacs;

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
        ];

        masApps = {
          "wireguard" = 1451685025;
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

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
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

            programs.direnv.enable = true;

            programs.git.enable = true;
            programs.git.userName = "Jeff Kreeftmeijer";
            programs.git.userEmail = "jeff@kreeft.me";
            programs.git.signing.key = "0x90A581FD6D796692";
            programs.git.signing.signByDefault = true;
            programs.git.extraConfig.init.defaultBranch = "main";
            programs.git.extraConfig.github.user = "jeffkreeftmeijer";
            programs.git.ignores = [
              "DS_Store"
              ".envrc"
              ".devenv*"
              "devenv.local.nix"
              ".direnv"
              ".pre-commit-config.yaml"
            ];

            programs.zsh.enable = true;
            programs.zsh.historySubstringSearch.enable = true;
            programs.zsh.initExtra =
            ''
            source /etc/profiles/per-user/$USER/share/bash-completion/completions/git-prompt.sh
            setopt PROMPT_SUBST
            export PS1='%~ $(__git_ps1 "(%s) ")%# '
            export RPS1=
            '';
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
