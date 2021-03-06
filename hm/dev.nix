{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      niv
      cachix
        
      # Haskell stuffs
      stack
      cabal2nix
      cabal-install
      nix-prefetch-git
      ghcid
      hlint
      stylish-haskell
      haskellPackages.hasktags

      # For linting shell
      shellcheck

      # For linting Nix on doom-emacs
      nixfmt   
    ];

    file.".stack/config.yaml".text =       
      ''
        templates:
          params:
            author-email: archbung@gmail.com
            author-name: Hizbullah Abdul Aziz Jabbar
            copyright: 'Copyright (c) 2020 Hizbullah Abdul Aziz Jabbar'
            github-username: archbung
      '';
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

    delta.enable = true;

    signing = {
      key = "0xC2FCAFB1282DB020";
      signByDefault = true;
    };

    extraConfig = {
      core.editor = "${pkgs.neovim}/bin/nvim";
    };

  };

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
  };

  services.lorri.enable = true;
}
