{ config, pkgs, ... }:
let firefox = pkgs.firefox-beta-bin;
in
{
  imports = [ ../../nix/common.nix ];

  home = {
    sessionVariables = { BROWSER = "${firefox}/bin/firefox"; };

    packages = with pkgs; [ steam zoom-us ];
  };

  programs.firefox = {
    enable = true;
    package = firefox;
  };
}
