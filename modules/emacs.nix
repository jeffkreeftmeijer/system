{ pkgs, ... }:
{
  home.packages = [(pkgs.emacsWithPackagesFromUsePackage {
    config = ../emacs/default.el;
    defaultInitFile = true;
    package = pkgs.emacsGit.override {
      treeSitterPlugins = with pkgs.tree-sitter-grammars; [
        tree-sitter-elixir
        tree-sitter-heex
      ];
    };

    extraEmacsPackages = epkgs: [
      epkgs.dockerfile-mode
      epkgs.elixir-mode
      epkgs.git-modes
      epkgs.ledger-mode
      epkgs.markdown-mode
      epkgs.nix-mode
      epkgs.yaml-mode
    ];

    override = epkgs: epkgs // {
      linguist = pkgs.callPackage ../pkgs/linguist.el {
        trivialBuild = epkgs.trivialBuild;
      };
    };
  })];
}
