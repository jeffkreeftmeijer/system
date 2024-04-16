{ system, ... }:

{
  users.users.jeff = {
    home = "/Users/jeff";
    description = "Jeff Kreeftmeijer";
  };

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  nixpkgs.hostPlatform = system;
}
