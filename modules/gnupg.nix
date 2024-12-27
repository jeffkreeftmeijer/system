{ pkgs, ... }:

{
  home-manager.users.jeff.programs.gpg.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
