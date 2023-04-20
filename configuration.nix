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
}
