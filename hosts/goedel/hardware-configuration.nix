{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"
    ];
    initrd.kernelModules = [ "i915" ];

    kernelModules = [ "kvm-intel" "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  hardware = {
    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

    opengl.extraPackages = with pkgs; [
      vaapiIntel vaapiVdpau libvdpau-va-gl intel-media-driver
    ];

    trackpoint = {
      enable = true;
      emulateWheel = true;
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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
