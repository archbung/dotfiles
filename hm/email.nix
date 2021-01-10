{ config, pkgs, ... }:
let realName = "Hizbullah Abdul Aziz Jabbar";
in
{
  accounts.email = {
    maildirBasePath = "mail";
    accounts.gmail = {
      inherit realName;
      userName = "archbung";
      address = "archbung@gmail.com";
      flavor = "gmail.com";
      primary = true;
      passwordCommand = "pass email/gmail";
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [
          "*"
          "![Gmail]*"
          "[Gmail]/Sent Mail"
          "[Gmail]/Starred"
          "[Gmail]/All Mail"
          "[Gmail]/Drafts"
        ];
      };
      msmtp.enable = true;
      notmuch.enable = true;
    };
  };

  programs.mbsync.enable = true;

  programs.msmtp.enable = true;

  programs.notmuch = {
    enable = true;
    hooks = {
      postNew = ''
        notmuch tag -inbox -- tag:inbox and from:archbung@gmail.com or from:s8hijabb@stud.uni-saarland.de
        notmuch tag +job +promotion -inbox -- tag:inbox and from:"/@*glassdoor.com/" or from:"/@*devpost.com/"
        notmuch tag +play +promotion -inbox -- tag:inbox and from:noreply@steampowered.com or from:"/@*reddit.com/"
        notmuch tag +fitness +promotion -inbox -- tag:inbox and from:"/@*zerofasting.com/" or from:"/@*nike.com/" or from:"/@jameda.de/"
        notmuch tag +promotion -inbox -- tag:inbox and from:"/@wg-gesucht.de/" or from:"/@members.babbel.com/" or from:"/@*headspace.com/" or from:"/@*any.do/" or from:"/@*zerofasting.com/"
        notmuch tag +banking -inbox -- tag:inbox and from:"/n26.com/" or from:"/@*paypal.de/"
        notmuch tag +shopping -inbox -- tag:inbox and from:"/@*amazon.*/" or from:"/@*myhermes.de/" or from:"/@*saturn.de/" or from:pricealert@keepa.com
        notmuch tag +newsletter -inbox -- tag:inbox and from:"/@*readdlenews.com/" or from:"/@*eatthismuch.com/" or from:"/@*sleepycycle.com/"
        notmuch tag +trash -inbox -- tag:inbox and from:"/@mail.instagram.com/" or from:"/@facebookmail.com/" or from:"/@*gotinder.com/"
        notmuch tag +work -inbox -- tag:inbox and from:"/@cispa.saarland/" or from:"/cispa.de/"
        notmuch tag +school -inbox -- tag:inbox and from:"/uni-saarland.de/"
        notmuch tag +git -inbox -- tag:inbox and from:"/@github.com/" or from:"/@gitlab*/"
        notmuch tag +pandoc +forum -inbox -- tag:inbox and from:pandoc-discuss@googlegroups.com or to:pandoc-discuss@googlegroups.com
        notmuch tag +nix +forum -inbox -- tag:inbox and from:nixos1@discoursemail.com
        notmuch tag +ledger +forum -inbox -- tag:inbox and from:ledger-cli@googlegroups.com or to:ledger-cli@googlegroups.com
        notmuch tag +tamarin +forum -inbox -- tag:inbox and from:tamarin-prover@googlegroups.com or to:tamarin-prover@googlegroups.com
        notmuch tag +haskell +forum -inbox -- tag:inbox and from:"/@haskell.org/" or to:"/@haskell.org/"
      '';
      preNew = "mbsync --all";
    };
  };

  programs.neomutt = { enable = true; };

  programs.password-store.enable = true;

  home = {
    packages = with pkgs; [ w3m ];

    file.".config/neomutt".source = ../config/neomutt;
  };
}
