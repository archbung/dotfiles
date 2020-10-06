{ config, pkgs, ... }:

let firefox = pkgs.firefox-beta-bin;
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
