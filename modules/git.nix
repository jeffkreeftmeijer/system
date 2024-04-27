{
  home-manager.users.jeff.programs.git = {
    enable = true;
    userName = "Jeff Kreeftmeijer";
    userEmail = "jeff@kreeft.me";
    signing = {
      key = "0xDBE78FAED96BF0D0";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "jeffkreeftmeijer";
      pull.rebase = true;
    };
    ignores = [ ".DS_Store" ];
  };
}
