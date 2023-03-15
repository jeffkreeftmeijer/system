{ pkgs, ... }:
{
  home.packages = [ pkgs.ncurses ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    escapeTime = 0;
  };
}
