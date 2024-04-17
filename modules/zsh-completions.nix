{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.zsh-completions ];
}
