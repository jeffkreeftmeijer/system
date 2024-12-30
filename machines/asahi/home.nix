{ config, pkgs, configured-emacs, system, ... }:

{
  home.username = "jeff";
  home.homeDirectory = "/home/jeff";

  home.stateVersion = "24.11";
  programs.emacs.package = configured-emacs.packages.${system}.configured-emacs;
}
