{ pkgs, config, inputs, ... }:

{
  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
