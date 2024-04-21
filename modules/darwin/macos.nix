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
      "scroll-to-open" = true; # Scroll on a Dock icon to see its windows
    };
    "com.apple.finder" = {
      CreateDesktop = false; # Don't show icons on the Desktop
      DisableAllAnimations = true; # Disable animations
      ShowStatusBar = true; # Show status bar
      ShowPathbar = true; # Show path bar (breadcrumbs)
      "_FXShowPosixPathInTitle" = true; # Show full path
    };
    "com.apple.ical" = { "Show Week Numbers" = true; };
    "com.apple.screensaver" = {
      idleTime = 0; # Disable screen saver
    };
    "com.apple.safari" = {
      IncludeDevelopMenu = true;
      ShowFullURLInSmartSearchField = true;
      AutoFillPasswords = true;
    };
    "com.apple.universalaccess" = { reduceTransparency = true; };
    "com.apple.windowmanager" = {
      AppWindowGroupingBehavior = true; # Group windows by type
      AutoHide = true; # Automatically hide Stage Manager
      GloballyEnabled = false; # Disable Stage Manager
    };
    NSGlobalDomain = {
      AppleShowAllFiles = true; # Show hidden files in Finder
      AppleShowAllExtensions = true; # Show file extensions in Finder
      "com.apple.sound.beep.volume" = 0.0;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };
}
