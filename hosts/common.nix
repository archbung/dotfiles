# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot.kernel.sysctl = { "vm.swappiness" = 1; };
  hardware.enableRedistributableFirmware = true;

  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  environment.systemPackages = with pkgs; [
    sshfs
    exfat
    ntfs3g
  ];

  # CUPS
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluezFull;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true; # Also enables hardware.opengl

    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";

    # Touchpad
    libinput = {
      enable = true;
      naturalScrolling = true;
    };

    # Display manager
    displayManager.startx.enable = true;
  };

  # SSD support
  services.fstrim.enable = true;

  # Keep hardware clock in sync
  services.chrony.enable = true;

  users.users.archbung = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nix = let users = [ "root" "archbung" ]; in {
    trustedUsers = users;
    allowedUsers = users;
  };
}
