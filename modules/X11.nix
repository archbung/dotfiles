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
  };
}
