{ pkgs, ... }:
{
  home.packages = [ pkgs.ncurses ];

  programs.tmux.enable = true;
}
