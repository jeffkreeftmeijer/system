{ pkgs, ... }:

{
  home-manager.users.jeff = {
    programs = {
      password-store.enable = true;
      browserpass.enable = true;
    };

    home.packages = [
      pkgs.wl-clipboard
    ];
  };
}
