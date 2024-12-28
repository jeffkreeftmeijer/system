{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.dconf.enable = true;

  home-manager.users.jeff.dconf.settings = {
    "org/gnome/desktop/background" ={
      picture-uri = "file:///home/jeff/system/assets/win95.png";
      picture-uri-dark = "file:///home/jeff/system/assets/win95.png";
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["caps:escape"];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };
  };
}
