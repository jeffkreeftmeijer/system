{
   services.nix-daemon.enable = true;
   homebrew.enable = true;
   homebrew.casks = [
     "slack"
     "tunnelblick"
     "zoomus"
   ];
   homebrew.onActivation.cleanup = "zap";
}