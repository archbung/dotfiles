{ config, pkgs, lib, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
      autoPrune = { enable = true; dates = "weekly"; };
    };
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-machine
  ];
}
