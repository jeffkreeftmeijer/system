{
  home-manager.users.jeff.programs.gpg.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager.users.jeff.programs.zsh.initExtra = ''
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  '';
}
