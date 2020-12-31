{ config, lib, pkgs, ... }:

{
  imports = [
    ./gpg.nix
    ./dev
    ./shells.nix
    ./terminal
    ./gui
    ./email
    ./irc.nix

    # Uncomment the appropriate option
    ./heisenberg.nix
    #./goedel.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "archbung";
    homeDirectory = "/home/archbung";

    sessionVariables = {
      LEDGER_FILE = "${config.home.homeDirectory}/org/personal.journal";
    };

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

    packages = with pkgs; [
      ledger
      noto-fonts
      openconnect
      mpv
      zoom-us
    ];
  };

  programs.feh.enable = true;

  services.syncthing.enable = true;

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
