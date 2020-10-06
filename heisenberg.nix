{ config, pkgs, ... }:

let firefox = pkgs.latest.firefox-beta-bin;
in
{
  home = {
    sessionVariables = {
      BROWSER = "${firefox}/bin/firefox";
    };

    packages = with pkgs; [
      steam
    ];
  };

  programs.firefox = {
    enable = true;
    package = firefox;
  };
}
