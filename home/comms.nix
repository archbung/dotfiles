{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zoom-us
    openconnect
  ];
}
