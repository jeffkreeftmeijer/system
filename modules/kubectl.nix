{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.kubectl ];
}
