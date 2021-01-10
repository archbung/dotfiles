{ config, pkgs, ... }:
let
  baseSettings = { font_size = 12; };
  colorScheme = import ../config/kitty/onedark.nix;
  settings = baseSettings // colorScheme;
in
{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.inconsolata;
      name = "Inconsolata";
    };
    inherit settings;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../config/tmux/tmux.conf;
  };
}
