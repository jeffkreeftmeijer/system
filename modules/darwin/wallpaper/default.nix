{
  system.activationScripts.postUserActivation.text = ''
    osascript -e "
      tell application \"System Events\"
        tell every desktop
          set picture to \"~/.config/nix/modules/darwin/wallpaper/win95.png\"
        end tell
      end tell"
  '';
}
