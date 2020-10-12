{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  networking.hostname = "goedel";
  networking.networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  programs.light.enable = true;

  services.xserver = {
    videoDrivers = [ "intel" "mesa" ];
    libinput.tapping = true;
  };

  # TODO: enable tlp-rdw
  services.tlp = {
    enable = true;
    settings = {
      "START_CHARGE_THRESH_BAT0" = "75";
      "STOP_CHARGE_THRESH_BAT0" = "80";
      "START_CHARGE_THRESH_BAT1" = "75";
      "STOP_CHARGE_THRESH_BAT1" = "80";
      "CPU_SCALING_GOVERNOR_ON_AC" = "performance";
      "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
    };
  };

  services.thinkfan = {
    enable = true;
    smartSupport = true;
  };

  services.upower.enable = true;

  users.users.archbung.extraGroups = [
    "networkmanager" "video"  # Enable setting backlight via `light`
  ];

  home-manager.users.archbung = ./goedel.nix;
}
