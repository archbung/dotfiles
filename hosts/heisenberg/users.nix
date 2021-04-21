{ config, pkgs, lib, ... }:

{
  users.users.archbung = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
  environment.pathsToLink = [ "/share/zsh" ];
}
