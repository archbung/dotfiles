{ config, pkgs, ... }:

{
  programs.gpg.enable = true;

  programs.keychain = {
    enable = true;
    extraFlags = [ "--quiet" ];
    keys = [ "id_github" "id_gitlab" ];
    agents = [ "ssh" ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
    extraConfig =
    ''
      allow-loopback-pinentry
    '';
  };

  home.sessionVariables = {
    GPG_TTY = "$(tty)";
  };

  home.packages = with pkgs; [
    gcr  # for gnome3 pinentry
  ];
}
