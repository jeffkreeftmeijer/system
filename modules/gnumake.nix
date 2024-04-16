{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gnumake ];
}
