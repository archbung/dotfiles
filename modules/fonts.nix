{ pkgs, config, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fonts= with pkgs; [
      noto-fonts
      symbola

      material-design-icons
      (nerdfonts.override { fonts = [
        "RobotoMono"
        "FiraCode"
        "InconsolataGo"
      ]; })
    ];

    # Use user-defined fonts instead of the default ones
    enableDefaultFonts = false;
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif Display" ];
      sansSerif = [ "Noto Sans Display" ];
      monospace = [ "RobotoMono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
