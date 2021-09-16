{ pkgs, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
  };

  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    fd
    gnutls
    zstd
    (aspellWithDicts (ds : with ds; [
      en en-computers en-science
    ]))
    languagetool
    sqlite
    neovim-nightly
    vscodium
  ];

  home.file = {
    ".config/doom".source = ./doom;
  };

  home.sessionVariables = {
    DOOMDIR = "${config.home.homeDirectory}/.config/doom";
  };
}
