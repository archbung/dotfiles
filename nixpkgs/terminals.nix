{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.fira-code;
      name = "Fira Code Light";
      size = 10;
    };
    settings = {
      # Onedark theme
      cursor = "#abb2bf";
      cursor_text_color = "#5c6370";
      foreground = "#abb2bf";
      background = "#282c34";
      selection_foreground = "#5c6370";
      selection_background = "#abb2bf";
      color0 = "#5c6370";
      color8 = "#4b5263";
      color1 = "#e06c75";
      color9 = "#be5046";
      color2 = "#98c379";
      color10 = "#98c379";
      color3 = "#e5c07b";
      color11 = "#d19a66";
      color4 = "#61afef";
      color12 = "#61afef";
      color5 = "#c678dd";
      color13 = "#c678dd";
      color6 = "#56b6c2";
      color14 = "#56b6c2";
      color7 = "#abb2bf";
      color15 = "#3e4452";
    };
  };

  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Fira Code 10";
    lines = 2;
    width = 100;
    location = "top";
    scrollbar = false;
    separator = "none";
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      modi = "window,drun,ssh,combi";
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      font = "Inconsolata 12";
    };
  };

  home.packages = with pkgs; [
    ranger
  ];
}
