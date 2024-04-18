{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.blesh ];
  home-manager.users.jeff.programs.bash.enable = true;
}
