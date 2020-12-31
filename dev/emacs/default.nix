{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # Emacs
      binutils
      emacsPgtkGcc

      # Doom deps
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls

      # Optional deps
      fd
      imagemagick
      zstd # for undo-fu

      # Module deps
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      languagetool
      sqlite # for org-roam
    ];

    sessionVariables = {
      DOOMDIR = "${config.home.homeDirectory}/.config/doom";
    };

    file.".config/doom".source = ./doom;
  };

  services.emacs.socketActivation.enable = true;
}
