{
  home-manager.users.jeff.programs = {
    bash.enable = true;
    zsh.enable = true;
    atuin = {
      enable = true;
      settings = {
        style = "full";
        show_preview = true;
      };
    };
  };
}
