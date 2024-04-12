{
  home-manager.users.jeff.targets.darwin.defaults = {
    "com.apple.dock" = {
      appswitcher-all-displays = true; # Show the app switcher on all displays
      autohide = true; # Automatically hide the dock
      autohide-delay = 0.0; # ... immediately
      autohide-time-modifier = 0.0; # ... and instantly
      launchanim = false; # No launch animations
      mineffect = "scale"; # Use "scale" effect when minimising windows
      static-only = true; # Only show open apps in the Dock
      tilesize = 64; # Reset the Dock icon size to 64
    };
    "com.apple.finder" = {
      DisableAllAnimations = true; # Disable animations
      ShowStatusBar = true; # Show status bar
      ShowPathbar = true; # Show path bar (breadcrumbs)
      "_FXShowPosixPathInTitle" = true; # Show full path
    };
    "com.apple.ical" = {
      "Show Week Numbers" = true;
    };
    "com.apple.safari" = {
      IncludeDevelopMenu = true;
      ShowFullURLInSmartSearchField = true;
      AutoFillPasswords = true;
    };
    "com.apple.universalaccess" = {
      reduceTransparency = true;
    };
    NSGlobalDomain = {
      AppleShowAllFiles = true; # Show hidden files in Finder
      AppleShowAllExtensions = true; # Show file extensions in Finder
      "com.apple.sound.beep.volume" = 0.000;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };
}
