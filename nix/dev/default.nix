{ config, pkgs, ... }:

{
  imports = [
    ./neovim
    ./texlive
    ./haskell.nix
    ./emacs.nix
  ];

  home.packages = with pkgs; [
    niv cachix
    shellcheck
    terraform
  ];

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

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
  };

  services.lorri.enable = true;
}
