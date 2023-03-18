{ pkgs, ... }:
{
  home.packages = [(pkgs.emacsWithPackagesFromUsePackage {
    config = ../emacs/default.el;
    defaultInitFile = true;
    package = pkgs.emacsGit;
  })];
}
