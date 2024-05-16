{ pkgs, ... }:

{
  home-manager.users.jeff.home.packages = [ pkgs.slack ];
  system.activationScripts.postUserActivation.text = ''
    defaults write ~/Library/Preferences/com.tinyspeck.slackmacgap.plist SlackNoAutoUpdates -bool YES
  '';
}
