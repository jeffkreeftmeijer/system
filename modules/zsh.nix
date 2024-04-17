{ pkgs, ... } :

{
  programs.zsh.enable = true;
  home-manager.users.jeff.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
  };
}
