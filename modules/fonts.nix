{ pkgs, config, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      noto-fonts
      symbola
      material-design-icons
      (nerdfonts.override { fonts = [
        "RobotoMono"
        "FiraCode"
        "InconsolataGo"
        "Hack"
      ];})
    ];

    enableDefaultFonts = false;
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif Display" ];
      sansSerif = [ "Noto Sans Display" ];
      monospace = [ "InconsolataGo Nerd Font"];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
