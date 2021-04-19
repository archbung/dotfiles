{ config, pkgs, lib, ... }:

{
  security.protectKernelImage = true;
  boot.loader.systemd-boot.editor = false;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
