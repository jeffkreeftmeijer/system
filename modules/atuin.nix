{
  home-manager.users.jeff.programs = {
    bash.enable = true;
    atuin = {
      enable = true;
      settings = {
        style = "full";
        show_preview = true;
      };
    };
  };
}
