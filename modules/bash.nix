{ pkgs, lib, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.blesh ];
  home-manager.users.jeff.programs.bash = {
    enable = true;
    bashrcExtra = lib.mkBefore ''
      [[ $- == *i* ]] && source '${pkgs.blesh}/share/blesh/ble.sh' --attach=none
    '';
    initExtra = lib.mkAfter ''
      [[ ''${BLE_VERSION-} ]] && ble-attach
    '';
  };
}
