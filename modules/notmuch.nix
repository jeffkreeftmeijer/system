{
  home-manager.users.jeff = {
    programs.notmuch.enable = true;

    accounts.email.accounts.kreeft = {
      address = "jeff@kreeft.me";
      realName = "Jeff Kreeftmeijer";
      primary = true;
      notmuch.enable = true;
    };
  };
}
