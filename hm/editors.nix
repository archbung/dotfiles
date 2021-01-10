{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      editorconfig-core-c

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

    file.".config/doom".source = ../config/doom;

    file.".config/nvim/syntax".source = ../config/nvim/syntax;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = builtins.readFile ../config/nvim/init.vim;
    };
  };

  services.emacs.socketActivation.enable = true;
}
