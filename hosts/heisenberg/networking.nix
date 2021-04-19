{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "heisenberg";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp34s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
