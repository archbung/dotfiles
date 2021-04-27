{ config, pkgs, lib, ... }:

{
  # Prevent replacing the running kernel without reboot
  security.protectKernelImage = true;

  # Enable RealtimeKit system service
  security.rtkit.enable = true;

  # Disable editing the boot loader entries
  boot.loader.systemd-boot.editor = false;

  # Mount tmpfs on RAM
  boot = {
    tmpOnTmpfs = lib.mkDefault true;
    cleanTmpDir = lib.mkDefault (!config.boot.tmpOnTmpfs);
  };

  # Use doas instead of sudo
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        noPass = true;
      }
    ];
  };

  security.acme = {
    acceptTerms = true;
    email = "hizbullah.abdul@protonmail.com";
  };
}
