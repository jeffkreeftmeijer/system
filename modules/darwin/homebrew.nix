{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };

  home-manager.users.jeff.programs.zsh = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
