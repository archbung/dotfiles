{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # (steam.override { withJava = true; nativeOnly = true; })
  ];
}
