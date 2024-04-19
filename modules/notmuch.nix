{
  home-manager.users.jeff = {
    programs.notmuch.enable = true;
    programs.mbsync.enable = true;

    accounts.email.accounts.kreeft = {
      address = "jeff@kreeft.me";
      userName = "jeff@kreeft.me";
      realName = "Jeff Kreeftmeijer";
      imap.host = "imap.transip.email";
      passwordCommand =
        "security find-generic-password -w -a jeff@kreeft.me -s imap.transip.email";
      primary = true;
      notmuch.enable = true;
      mbsync.enable = true;
    };
  };
}
