{ config, pkgs, ... }:

{
  programs.irssi = {
    enable = true;
    networks = {
      freenore = {
        nick = "archbung";
        server = {
          address = "chat.freenode.net";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          nixos.autoJoin = true;
        };
      };
    };
  };
}
