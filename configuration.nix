{
   services.nix-daemon.enable = true;
   homebrew.enable = true;
   homebrew.casks = [
     "slack"
     "tunnelblick"
     "zoomus"
   ];
   homebrew.masApps = {
     "Adblock Plus for Safari" = 1432731683;
   };
   homebrew.onActivation.cleanup = "zap";
}
