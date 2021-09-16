{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking = {
    hostName = "heisenberg";
    interfaces.enp34s0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
  };

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };

    udisks2.enable = true;

    xserver.xrandrHeads = [
      { output = "DVI-D-0"; primary = true; }
      #{ output = "DisplayPort-0"; monitorConfig = ''Option "RightOf" "DVI-D-0"''; }
    ];
  };
}
