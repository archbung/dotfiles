{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ ripgrep fd clang ];

    file."~/.emacs.d/init.el".source = ./init.el;
  };

  programs.emacs.enable = true;

  services.emacs.socketActivation.enable = true;
}
