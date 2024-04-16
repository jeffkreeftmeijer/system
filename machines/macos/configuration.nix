{ system, ... }:

{
  users.users.jeff = {
    home = "/Users/jeff";
    description = "Jeff Kreeftmeijer";
  };

  networking = {
    computerName = "Jeff’s Laptop";
    hostName = "macos";
  };

  time.timeZone = "Europe/Amsterdam";

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
}
