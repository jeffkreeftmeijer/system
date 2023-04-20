{
   services.nix-daemon.enable = true;
   homebrew.enable = true;
   homebrew.casks = [
     "slack"
     "spotify"
     "tunnelblick"
     "zoomus"
     "zotero"
   ];
   homebrew.masApps = {
     "Adblock Plus for Safari" = 1432731683;
   };
   homebrew.onActivation.cleanup = "zap";

   # Show the app switcher on all displays, instead of just the current one
   system.defaults.dock.appswitcher-all-displays = true;

   # Automaticalky hide the dock, immediately and instantly
   system.defaults.dock.autohide = true;
   system.defaults.dock.autohide-delay = 0.0;
   system.defaults.dock.autohide-time-modifier = 0.0;

   # No launch animations
   system.defaults.dock.launchanim = false;

   # Only show open apps in the Dock
   system.defaults.dock.static-only = false;

   # Reset the Dock icon size to 64
   system.defaults.dock.tilesize = 64;
}
