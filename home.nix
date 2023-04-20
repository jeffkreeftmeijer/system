{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager.nix
    ./modules/direnv.nix
    ./modules/emacs.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
  };
}
