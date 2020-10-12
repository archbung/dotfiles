{ config, pkgs, ... }:

{
  imports = [ ../../nix/common.nix ];

  home.packages = with pkgs; [ zoom-us networkmanagerapplet stalonetray ];

  home.file = {
    nmgui = {
      text = ''
        #!/bin/sh
        nm-applet 2>&1 > /dev/null &
        stalonetray 2>&1 > /dev/null
        kill -a nm-applet
      '';
      target = "scripts/nmgui.sh";
      executable = true;
    };
  };

  programs.chromium.enable = true;

  services.grobi = {
    enable = true;
    rules = [{
      name = "Mobile";
      outputs_disconnected = [ "DP-1" "HDMI-1" ];
      configure_single = "eDP-1";
      primary = true;
      atomic = true;
    }];
  };
}
