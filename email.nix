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
          "*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail" "[Gmail]/Drafts"
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
      postNew =
        ''
        notmuch tag +job +promotion -inbox -- tag:inbox and from:noreply@glassdoor.com
        notmuch tag +play +promotion -inbox -- tag:inbox and from:noreply@steampowered.com
        notmuch tag +promotion -inbox -- tag:inbox and from:"/@wg-gesucht.de/" or from:"/@members.babbel.com/" or from:"/@amazon.com/"
        notmuch tag +newsletter -inbox -- tag:inbox and from:"/@readdlenews.com/" or from:"/@eatthismuch.com/"
        notmuch tag +trash -inbox -- tag:inbox and from:"/@mail.instagram.com/"
        notmuch tag +trash -inbox -- tag:inbox and from:"/@facebookmail.com/"
        notmuch tag +work -inbox -- tag:inbox and from:"/@cispa.saarland/"
        notmuch tag +school -inbox -- tag:inbox and from:"/uni-saarland.de/"
        notmuch tag +github -inbox -- tag:inbox and from:"/@github.com/"
        notmuch tag -inbox -- from:archbung@gmail.com
        notmuch tag +pandoc +forum -inbox -- tag:inbox and from:pandoc-discuss@googlegroups.com or to:pandoc-discuss@googlegroups.com
        notmuch tag +nix +forum -inbox -- tag:inbox and from:nixos1@discoursemail.com
        notmuch tag +ledger +forum -inbox -- tag:inbox and from:ledger-cli@googlegroups.com or to:ledger-cli@googlegroups.com
        notmuch tag +tamarin +forum -inbox -- tag:inbox and from:tamarin-prover@googlegroups.com or to:tamarin-prover@googlegroups.com
        '';
      preNew = "mbsync --all";
    };
  };

  programs.neomutt = {
    enable = true;
  };

  programs.password-store.enable = true;

  home = {
    packages = with pkgs; [ w3m ];

    file.neomutt = {
      source = ./lib/neomutt;
      target = ".config/neomutt";
    };
  };
} 
