{
  programs.git = {
    enable = true;
    userName = "Jeff Kreeftmeijer";
    userEmail = "jeffkreeftmeijer@gmail.com";
    extraConfig.init.defaultBranch = "main";
    ignores = ["DS_Store"];
  };
}
