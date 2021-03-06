{ config, pkgs, ... }:
let shellAliases = {
  ls = "${pkgs.exa}/bin/exa";
  ll = "${pkgs.exa}/bin/exa -lh";
  cp = "cp --reflink=auto";
  vi = "nvim";
};
in
{
  home = {
    sessionVariables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
    };

    packages = with pkgs; [
      exa
      ranger
    ];

  };

  programs.autojump.enable = true; # Autojump enables bash integration by default

  programs.bat.enable = true;

  programs.bash = {
    enable = true;

    historyControl = [
      "ignoredups"
      "erasedups"
    ];

    historyIgnore = [
      "ll"
      "ls"
      "cd"
    ];

    shellOptions = [
      "histappend"
      "checkjobs"
    ];

    inherit shellAliases;
  };

  # View directories as trees
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

  # Fancy history
  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    keyScheme = "vim";
  };

  # Fancy prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
