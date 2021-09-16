{ config, pkgs, lib, inputs, ... }:

{
  networking = {
    useDHCP = false;
    wireless.iwd = {
      enable = true;
      settings = {
        "General" = { "EnableNetworkConfiguration" = true; };
        "Settings" = { "AutoConnect" = true; };
        "Network" = {
          "EnableIPv6" = true;
          "NameResolvingSystem" = "systemd";
          "RoutePriorityOffset" = 300;
        };
      };
    };
  };

  services.resolved.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = { Enable = "Source,Sink,Media,Socket"; };
    };
  };
}
