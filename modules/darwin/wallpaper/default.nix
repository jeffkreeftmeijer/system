{
  system.activationScripts.postUserActivation.text = ''
    osascript -e "
      tell application \"System Events\"
        tell every desktop
          set picture to \"~/.config/nix/modules/darwin/wallpaper/dark.png\"
        end tell
      end tell"
  '';
}
