{ config, pkgs, lib, modulesPath, inputs, ... }:

let nixos-hardware = inputs.nixos-hardware.nixosModules;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.common-pc
    nixos-hardware.common-pc-ssd
    nixos-hardware.common-gpu-amd
    nixos-hardware.common-cpu-amd
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"
      ];
      kernelModules = [];
    };
    kernelPackages = pkgs.linuxPackages_5_11;
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [];
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.enable = lib.mkDefault true;
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "defaults" "compress=zstd" "subvol=root" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "defaults" "compress=zstd" "subvol=home" "nosuid" "nodev" "relatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/esp";
      fsType = "vfat";
      options = [ "defaults" "nosuid" "nodev" "noexec" "noatime" ];
    };

  swapDevices = [ { device = "/swap/swap.0"; } ];
}
