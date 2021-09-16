{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableVteIntegration = true;

    # Use vi keybindings
    defaultKeymap = "viins";

    history = {
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
  };

  programs.bat.enable = true;
  programs.exa = { enable = true; enableAliases = true; };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
