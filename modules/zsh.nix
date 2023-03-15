{ pkgs, ... }:
{
  home.packages = [ pkgs.git ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    historySubstringSearch.enable = true;
    initExtra =
    ''
    source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
    setopt PROMPT_SUBST
    export PS1='%~ $(__git_ps1 "(%s) ")%# '
    '';
    home.packages = [ pkgs.git ];
  };
}
