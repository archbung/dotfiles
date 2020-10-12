{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    amdvlk
  ];

  networking.hostName = "heisenberg";
  networking.wireless = {
    enable = true;
    networks = {
      "o2-WLAN33" = {
        pskRaw = "cffc437ab93ce7ca79e0437523a09469a5072e947869cfcb20d7706a7a3aa330";
      };
    };
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" "mesa" ];
    xrandrHeads = [
      { "output" = "DVI-D-0"; }
      { "output" = "DisplayPort-0"; "primary" = true; }
    ];
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  home-manager.users.archbung = ./heisenberg.nix;
}
