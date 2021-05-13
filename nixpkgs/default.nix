{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./browsers.nix
    ./devs.nix
    ./comms.nix
    ./editors.nix
    ./gui.nix
    ./secrets.nix
    ./shells.nix
    ./sound.nix
    ./terminals.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    activation = {
      disableCOW = lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
        $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
          $HOME/.local/share/Steam
        $DRY_RUN_CMD chattr +C $VERBOSE_ARG \
          $HOME/{documents,downloads,music,pictures,videos,.local/share/Steam}
      '';
      fixKeyDirsPermission = lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
        $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
          $HOME/{.ssh,.gnupg}
        $DRY_RUN_CMD chmod 700 $VERBOSE_ARG \
          $HOME/{.ssh,.gnupg}
      '';
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "\$HOME/desktop";
    documents = "\$HOME/documents";
    download = "\$HOME/downloads";
    music = "\$HOME/music";
    pictures = "\$HOME/pictures";
    publicShare = "\$HOME/public";
    templates = "\$HOME/templates";
    videos = "\$HOME/videos";
  };
}
