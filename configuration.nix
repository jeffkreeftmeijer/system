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
