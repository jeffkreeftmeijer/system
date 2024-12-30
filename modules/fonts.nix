{ pkgs, ... }:

{
  fonts.packages =
    [ pkgs.iosevka-bin (pkgs.iosevka-bin.override { variant = "aile"; }) ];
}
