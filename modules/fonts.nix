{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.iosevka-bin
    (pkgs.iosevka-bin.override { variant = "aile"; })
  ];
}
