{
  home-manager.users.jeff.programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$shell";
      add_newline = false;
      directory = {
        truncate_to_repo = false;
        truncation_length = 0;
        style = "fg:bright-cyan";
      };
      git_branch = {
        format = "[\\($branch(:$remote_branch)\\)]($style) ";
        style = "fg:bright-cyan";
      };
      shell = {
        zsh_indicator = "%";
        bash_indicator = "\\$";
        disabled = false;
        style = "fg:bright-cyan";
      };
    };
  };
}
