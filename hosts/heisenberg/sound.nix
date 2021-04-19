{ config, pkgs, lib, ... }:

{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true; # for Steam
    package = pkgs.pulseaudioFull;
  };

  environment.systemPackages = with pkgs; [
    pulsemixer
  ];
}
