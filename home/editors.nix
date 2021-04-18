{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      fugitive
      sensible
      vim-unimpaired
      commentary
      { plugin = vinegar;
        config =
        ''
          let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'  " start netrw with dot files hidden
        '';
      }
      { plugin = vim-polyglot;
        config =
        ''
          let g:tex_flavor = "latex"
          let g:vimtex_view_method = "zathura"
          let g:vimtex_quickfix_mode = 1
        '';
      }
      vim-gitgutter
      { plugin = fzf-vim;
        config =
        ''
          let g:fzf_buffers_jump = 1
          command! -bang -nargs=* GGrep
                \ call fzf#vim#grep(
                \   'git grep --line-number '.shellescape(<q-args>), 0,
                \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

          command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

          command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        '';
      }
      fzfWrapper
      { plugin = ultisnips;
        config =
        ''
          let g:UltiSnipsExpandTrigger = "<C-j>"
          let g:UltiSnipsJumpForwardTrigger = "<C-b>"
          let g:UltiSnipsJumpBackwardTrigger = "<C-z>"
        '';
      }
      vim-snippets
      { plugin = ale;
        config =
        ''
          let g:ale_fixers = {
                \   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
                \   'haskell': [ 'stylish-haskell' ],
                \ }
          let g:ale_linters = {
                \   'haskell': [ 'hlint' ],
                \ }
          let g:ale_list_window_size = 5
          let g:ale_fix_on_save = 1
        '';
      }
      vimtex
      onedark-vim
      { plugin = lightline-vim;
        config =
        ''
          set noshowmode
          let g:lightline = {
                \ 'colorscheme': 'onedark',
                \ 'active': {
                \   'left': [[ 'mode', 'paste', ],
                \            [ 'gitbranch', 'readonly', ]],
                \   'right':
                \     [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', ],
                \      [ 'lineinfo'], [ 'percent' ], [ 'filetype']]
                \   },
                \ 'component_function': {
                \   'gitbranch': 'fugitive#head',
                \   },
                \ 'component_expand': {
                \   'linter_checking': 'lightline#ale#checking',
                \   'linter_warnings': 'lightline#ale#warnings',
                \   'linter_errors': 'lightline#ale#errors',
                \   'linter_ok': 'lightline#ale#ok',
                \   },
                \ 'component_type': {
                \   'linter_checking': 'left',
                \   'linter_warnings': 'warning',
                \   'linter_errors': 'error',
                \   'linter_ok': 'left',
                \   },
                \ }
        '';
      }
      lightline-ale
      gv-vim
      vim-smoothie
    ];
    extraConfig = builtins.readFile ./config.vim;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
  };

  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    fd
    gnutls
    zstd
    (aspellWithDicts (ds : with ds; [
      en en-computers en-science
    ]))
    languagetool
    sqlite
  ];

  home.file = {
    ".config/doom".source = ./doom;
  };

  home.sessionVariables = {
    DOOMDIR = "${config.home.homeDirectory}/.config/doom";
  };
}
