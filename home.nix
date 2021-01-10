{ config, lib, pkgs, ... }:

{
  imports = [
    ./hm/browsers.nix
    ./hm/communications.nix
    ./hm/desktop.nix
    ./hm/dev.nix
    ./hm/documents.nix
    ./hm/editors.nix
    ./hm/email.nix
    ./hm/fonts.nix
    ./hm/gaming.nix
    ./hm/media.nix
    ./hm/secrets.nix
    ./hm/shells.nix
    ./hm/terminal.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "archbung";
    homeDirectory = "/home/archbung";

    activation = {
      disableCOW = lib.hm.dag.entryAfter [ "writeBoundary" ]
        ''
          $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
            $HOME/{downloads,.local/share/Steam,.ssh,.gnupg}

          $DRY_RUN_CMD chmod 700 $VERBOSE_ARG \
            $HOME/{.ssh,.gnupg}

          $DRY_RUN_CMD chattr +C $VERBOSE_ARG \
            $HOME/{downloads,.local/share/Steam}
        '';
    };
  };

  xdg.userDirs = {
    enable = true;
    desktop = "\$HOME/desktop";
    videos = "\$HOME/videos";
    music = "\$HOME/music";
    download = "\$HOME/downloads";
    documents = "\$HOME/documents";
    pictures = "\$HOME/pictures";
    publicShare = "\$HOME/public";
    templates = "\$HOME/templates";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
