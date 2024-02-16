{ pkgs, ... }:
{
  home.packages = [ pkgs.git ];
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;
  programs.zsh.historySubstringSearch.enable = true;
  programs.zsh.initExtra =
  ''
  source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
  setopt PROMPT_SUBST
  export PS1='%~ $(__git_ps1 "(%s) ")%# '
  export PATH=$PATH:/Applications/Docker.app/Contents/Resources/bin/
  '';
}
