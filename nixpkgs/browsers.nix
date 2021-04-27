{ pkgs, config, latest, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
