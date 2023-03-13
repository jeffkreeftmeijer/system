{ config, pkgs, ... }:

{
  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
    packages = with pkgs; [
    ];
  };

  programs.home-manager = {
    enable = true;
  };
}
