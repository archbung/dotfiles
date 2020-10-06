{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ripgrep fd clang
    ];

    sessionVariables = {
      DOOMDIR = "${config.home.homeDirectory}/.config/nixpkgs/lib/doom";
    };
  };

  programs.emacs.enable = true;

  services.emacs.socketActivation.enable = true;
}
