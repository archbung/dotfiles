{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";
    libinput = {
      enable = true;
      mouse.naturalScrolling = true;
    };
    displayManager.startx.enable = true;
    xrandrHeads = [
      {
        output = "DVI-D-0";
        primary = true;
      }
      {
        output = "DisplayPort-0";
        monitorConfig =
        ''
        Option "RightOf" "DVI-D-0"
        '';
      }
    ];
  };
}
