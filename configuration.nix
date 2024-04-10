{ system, ... }:

{
  users.users.jeff.home = "/Users/jeff";

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

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  nixpkgs.hostPlatform = system;
}
