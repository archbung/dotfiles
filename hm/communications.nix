{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zoom-us
    openconnect
  ];

  # IRC
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
