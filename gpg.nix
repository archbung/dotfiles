{ config, pkgs, ... }:

{
  programs.gpg.enable = true;

  home = {
    sessionVariables = {
      GPG_TTY = "$(tty)";
    };

    packages = with pkgs; [ gcr ];
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
