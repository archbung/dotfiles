{ config, pkgs, ... }:

{
  home.file.neovim = {
    source = ./syntax;
    target = ".config/nvim/syntax";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = builtins.readFile ./config.vim;

      plug.plugins = with pkgs.vimPlugins;
        [ fugitive sensible vim-polyglot vim-gitgutter nerdtree
          fzf-vim fzfWrapper
          ultisnips vim-snippets ale
          onedark-vim lightline-vim gv-vim
        ];
    };
  };
}
