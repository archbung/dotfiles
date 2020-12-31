{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../personal.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [ amdvlk ];

  networking.wireless = {
    enable = true;
    networks = {
      "Studenten-WG" = {
        pskRaw =
          "6fda6fd7e016941b52ba5e466f28fef52d2ecdebf84327b907110ca96c378926";
        priority = 50;
      };
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  home-manager.users.archbung = ./heisenberg.nix;
}
