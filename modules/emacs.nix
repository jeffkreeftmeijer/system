{ lib, ... } :

{
  home-manager.users.jeff.programs.emacs.enable = true;
  services.emacs.enable = true;
  home-manager.users.jeff.programs.zsh.initExtra = lib.mkAfter ''
    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
      source "$EAT_SHELL_INTEGRATION_DIR/zsh"
  '';
  home-manager.users.jeff.programs.bash.initExtra = lib.mkAfter ''
    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
      source "$EAT_SHELL_INTEGRATION_DIR/bash"
  '';
}
