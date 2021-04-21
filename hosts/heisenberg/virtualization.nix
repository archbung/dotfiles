{ config, pkgs, lib, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    x11docker
    docker-compose
    docker-machine
  ];
}
