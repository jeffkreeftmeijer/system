{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.jeff.shell = pkgs.zsh;
  home-manager.users.jeff.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
  };
}
