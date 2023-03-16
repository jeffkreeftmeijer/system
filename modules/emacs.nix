{ pkgs, ... }:
{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsGit-nox;
}
