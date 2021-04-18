{ pkgs, config, ... }:

{
  # TODO: somehow use inputs.mozilla-overlay
  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
