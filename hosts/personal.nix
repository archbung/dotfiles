{ config, lib, pkgs, ... }:

{
  time.timeZone = lib.mkDefault "Europe/Berlin";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  location = {
    latitude = "49.279530";
    longitude = "7.034970";
  };
}
