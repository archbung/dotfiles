{ config, pkgs, ... }:

{
  programs.gpg.enable = true;

  home = {
    sessionVariables = {
      GPG_TTY = "$(tty)";
    };

    packages = with pkgs; [ gcr ];
  };

  programs.keychain = {
    enable = true;
    extraFlags = [ "--quiet" ];
    keys = [ "id_cispa" "id_github" "id_gitlab" ];
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
}
