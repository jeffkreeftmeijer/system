{ lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.windowManager.session = lib.singleton {
    name = "exwm";
    start = "emacs --eval '(exwm-enable)'";
  };
}
