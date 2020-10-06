{ config, pkgs, ... }:

{
  imports = [
    ./dev/haskell.nix
    ./dev/texlive.nix 
    ./dev/emacs.nix
  ];

  home = {
    packages = with pkgs; [
      niv cachix
      shellcheck
      terraform
    ];

    file.neovim = {
      source = ./lib/nvim;
      target = ".config/nvim";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNixDirenvIntegration = true;
  };

  programs.git = {
    enable = true;
    userEmail = "archbung@gmail.com";
    userName = "Hizbullah Abdul Aziz Jabbar";
    aliases = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
        hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        type = "cat-file -t";
        dump = "cat-file -p";
    };

    signing = {
      key = "0xC2FCAFB1282DB020";
      signByDefault = true;
    };

    extraConfig = {
      core.editor = "${pkgs.neovim}/bin/nvim";
    };

  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      plug.plugins = with pkgs.vimPlugins;
        [ fugitive sensible vim-polyglot vim-gitgutter nerdtree
          fzf-vim fzfWrapper
          ultisnips vim-snippets ale
          onedark-vim lightline-vim gv-vim
        ];
      customRC = builtins.readFile ./lib/config.vim;
    };
  };

  programs.zathura = {
    enable = true;
    extraConfig =
    ''
    set font "Inconsolata 12"
    '';
  };

  services.lorri.enable = true;
}

