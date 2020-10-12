{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"
    ];
    initrd.kernelModules = [ ];

    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  hardware = {
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    opengl = {
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libva vaapiVdpau libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva vaapiVdpau libvdpau-va-gl
      ];
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=nixos" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=home" "nosuid" "nodev" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/esp";
      fsType = "vfat";
      options = [ "nosuid" "nodev" "noexec" ];
    };

  swapDevices = [ ];
}
