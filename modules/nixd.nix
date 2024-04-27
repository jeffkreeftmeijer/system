{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.nixd pkgs.nixpkgs-fmt ];
}
