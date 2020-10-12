{ config, pkgs, ... }:

{
  imports =
    [ ./gpg.nix ./dev ./shells.nix ./terminal ./gui.nix ./email ./irc.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "archbung";
    homeDirectory = "/home/archbung";

    sessionVariables = {
      LEDGER_FILE = "${config.home.homeDirectory}/org/personal.journal";
    };

    packages = with pkgs; [ hledger noto-fonts openconnect mpv ];
  };

  programs.feh.enable = true;

  services.syncthing.enable = true;

  xdg.userDirs = {
    enable = true;
    desktop = "$HOME/desktop";
    videos = "$HOME/videos";
    music = "$HOME/music";
    download = "$HOME/downloads";
    documents = "$HOME/documents";
    pictures = "$HOME/pictures";
    publicShare = "$HOME/public";
    templates = "$HOME/templates";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
