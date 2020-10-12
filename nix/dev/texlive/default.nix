{ config, pkgs, ... }:

{
  programs.texlive = {
    enable = true;
    extraPackages = pkgs: {
      inherit (pkgs)
      scheme-small latex latex-bin latexconfig latex-fonts tools pdftex luatex
      babel babel-english carlisle ec geometry graphics graphics-def hyperref lm
      marvosym oberdiek parskip
      mathtools amsmath amscls biblatex
      url csquotes latexmk
      stmaryrd mathpartir;
    };
  };

  programs.zathura = {
    enable = true;
    extraConfig =
    ''
    set font "Inconsolata 12"
    '';
  };
}
