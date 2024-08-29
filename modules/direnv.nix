{
  programs.direnv.enable = true;
  home-manager.users.jeff.programs.git.ignores = [ ".envrc" ".direnv" ];
}
