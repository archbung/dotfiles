{ pkgs, config, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;
  };

  programs.git = {
    enable = true;
    userEmail = "archbung@gmail.com";
    userName = "Hizbullah Abdul Aziz Jabbar";

    delta.enable = true;

    aliases = {
      st = "status";
      co = "checkout";
      ci = "commit";
      br = "branch";
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      type = "cat-file -t";
      dump = "cat-file -p";
    };

    signing = {
      key = "0xC2FCAFB1282DB020";
      signByDefault = true;
    };
  };
    
  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.texlive = {
    enable = true;
    extraPackages = ts: { 
      inherit (ts) collection-fontsrecommended algorithms; 
    };
  };


  services.lorri.enable = true;


  home.sessionVariables = {
    LEDGER_FILE = "${config.home.homeDirectory}/org/personal.ledger";
  };

  home.file.stack-config = {
    text =
    ''
       templates:
          params:
            author-email: archbung@gmail.com
            author-name: Hizbullah Abdul Aziz Jabbar
            copyright: 'Copyright (c) 2021 Hizbullah Abdul Aziz Jabbar'
            github-username: archbung
    '';
    target = ".stack/config.yaml";
  };

  home.packages = with pkgs; [
    # Shell
    shellcheck

    # Haskell
    cabal2nix
    cabal-install
    nix-prefetch-git
    stack
    hlint
    stylish-haskell
    ghcid

    # Nix
    nixfmt

    # Rust
    rustup

    ledger
    pandoc
  ];
}
