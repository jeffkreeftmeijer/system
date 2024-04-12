{
  home-manager.users.jeff.targets.darwin.defaults = {
    "com.apple.dock" = {
      appswitcher-all-displays = true; # Show the app switcher on all displays
      autohide = true; # Automatically hide the dock
      autohide-delay = 0.0; # ... immediately
      autohide-time-modifier = 0.0; # ... and instantly
      launchanim = false; # No launch animations
      static-only = true; # Only show open apps in the Dock
      tilesize = 64; # Reset the Dock icon size to 64
    };
    "com.apple.ical" = {
      "Show Week Numbers" = true;
    };
    "com.apple.safari" = {
      IncludeDevelopMenu = true;
      ShowFullURLInSmartSearchField = true;
      AutoFillPasswords = true;
    };
  };
}
