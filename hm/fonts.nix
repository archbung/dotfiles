{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    fira-code
    symbola
  ];

  fonts.fontconfig.enable = true;

  gtk.font = {
    name = "Noto Serif Display 16";
  };
}
