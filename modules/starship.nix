{
  home-manager.users.jeff.programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$shell";
      add_newline = false;
      directory = {
        truncate_to_repo = false;
        style = "";
      };
      git_branch = {
        format = "[\\($branch(:$remote_branch)\\)]($style) ";
        style = "";
      };
      shell = {
        zsh_indicator = "%";
        bash_indicator = "\\$";
        disabled = false;
        style = "";
      };
    };
  };
}
