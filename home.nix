{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager.nix
    ./modules/git.nix
  ];

  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
  };
}
