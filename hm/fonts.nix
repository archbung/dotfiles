{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    fira-code
  ];
}
