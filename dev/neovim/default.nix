{ config, pkgs, ... }:

{
  home.file = {
    neovim-syntax = {
      source = ./syntax;
      target = ".config/nvim/syntax";
    };
    neovim-config = {
      source = ./config.vim;
      target = ".config/nvim/init.vim";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
