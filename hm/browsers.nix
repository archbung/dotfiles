{ config, pkgs, ... }:

let firefox = pkgs.latest.firefox-beta-bin;
in {
  home.sessionVariables = {
    BROWSER = "${firefox}/bin/firefox";
  };

  programs.firefox = {
    enable = true;
    package = firefox;
  };

  programs.chromium.enable = true;
}
