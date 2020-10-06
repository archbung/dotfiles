{ config, pkgs, ... }:

let shellAliases = {
      ls = "${pkgs.exa}/bin/exa";
      ll = "${pkgs.exa}/bin/exa -l";
      cp = "cp --reflink=auto";
    };
in
{
  home = {
    sessionVariables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
    };

    packages = with pkgs; [
      exa ranger
    ];

  };

  programs.bat.enable = true;

  programs.bash = {
    enable = true;
    enableAutojump = true;

    historyControl = [
      "ignoredups" "erasedups"
    ];

    historyIgnore = [
      "ll" "ls" "cd"
    ];

    shellOptions = [
      "histappend" "checkjobs"
    ];

    inherit shellAliases;
  };

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
  };

  programs.htop.enable = true;

  programs.keychain = {
    enable = true;
    extraFlags = [ "--quiet" ];
    keys = [ "id_cispa" "id_github" "id_gitlab" ];
    agents = [ "ssh" ];
  };

  programs.readline = {
    enable = true;
    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
      echo-control-characters = false;
      vi-ins-mode-string = "\\1\\e[6 q\\2";
      vi-cmd-mode-string = "\\1\\e[2 q\\2";
    };
    extraConfig = 
    ''$if mode=vi
        set keymap vi-command
        "\e[B": history-search-forward
        "\e[A": history-search-backward
        j: history-search-forward
        k: history-search-backward

        set keymap vi-insert
        "\e[B": history-search-forward
        "\e[A": history-search-backward
      $endif
    '';
  };

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    keyScheme = "vim";
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
