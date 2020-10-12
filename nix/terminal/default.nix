{ config, pkgs, ... }:

let
  baseSettings = { font_size = 12; };
  colorScheme = import ./kitty/onedark.nix;
  settings = baseSettings // colorScheme;
in {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.inconsolata;
      name = "Inconsolata";
    };
    inherit settings;
  };
}
