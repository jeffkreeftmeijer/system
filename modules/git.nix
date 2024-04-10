{
  home-manager.users.jeff.programs.git = {
    enable = true;
    userName = "Jeff Kreeftmeijer";
    userEmail = "jeff@kreeft.me";
    signing.key = "0x90A581FD6D796692";
    signing.signByDefault = true;
    extraConfig.init.defaultBranch = "main";
    extraConfig.github.user = "jeffkreeftmeijer";
    ignores = [ "DS_Store" ];
  };
}
