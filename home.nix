{ config, pkgs, ... }:

{
  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
  };

  programs.home-manager = {
    enable = true;
  };
}
