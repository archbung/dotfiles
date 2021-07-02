{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Networking
  networking = {
    hostName = "heisenberg";
    interfaces.enp34s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };

  # Steam
  programs.steam.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Services
  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };

    udisks2.enable = true;
  };

  documentation.info.enable = false;
}
