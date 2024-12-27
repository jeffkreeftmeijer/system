{ config, pkgs, ... }:

{
  home.username = "jeff";
  home.homeDirectory = "/home/jeff";

  home.stateVersion = "24.11";

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
  };
}
