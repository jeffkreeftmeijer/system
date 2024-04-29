{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages =
    [ (pkgs.aspellWithDicts (dicts: [ dicts.en ])) ];
}
