{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
  ];

  programs.feh.enable = true;
}
