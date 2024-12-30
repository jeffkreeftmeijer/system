{
  home-manager.users.jeff.programs = {
    bash.enable = true;
    atuin = {
      enable = true;
      settings = {
        style = "compact";
        show_preview = true;
      };
    };
  };
}
