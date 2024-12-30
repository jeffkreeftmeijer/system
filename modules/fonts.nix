{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages =
    [ pkgs.iosevka-bin (pkgs.iosevka-bin.override { variant = "aile"; }) ];
}
