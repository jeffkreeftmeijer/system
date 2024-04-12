{ system, ... }:

{
  users.users.jeff.home = "/Users/jeff";

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  nixpkgs.hostPlatform = system;
}
