{ config, pkgs, lib, ... }:

{
  boot = {
    loader.systemd-boot.editor = false;
    tmpOnTmpfs = lib.mkDefault true;
    cleanTmpDir = lib.mkDefault (!config.boot.tmpOnTmpfs);
  };

  security = {
    # Prevents replacing the running kernel without reboot
    protectKernelImage = true;  

    # Enable realtimekit system service
    rtkit.enable = true;

    # Use doas instead of sudo
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          noPass = true;
        }
      ];
    };
    acme = {
      acceptTerms = true;
      email = "archbung@gmail.com";
    };
  };
}
