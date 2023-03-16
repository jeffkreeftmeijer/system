{ pkgs, ... }:
{
  home.packages = [ pkgs.ncurses ];
  programs.tmux.enable = true;
  programs.tmux.sensibleOnTop = false;
  programs.tmux.escapeTime = 0;
}
