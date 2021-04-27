{ pkgs, config, ... }:

{
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans Display";
      size = 12;
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc";
    };
  };

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = "49.279530";
    longitude = "7.034970";
    settings = {
      redshift.adjustment-method = "randr";
      randr = {
        screen = 0;
    	};
    };
  };

  home.packages = with pkgs; [
    haskellPackages.xmobar
  ];

  home.file.".xmobarrc".text = builtins.readFile ./xmobarrc;

  home.file.".xinitrc".text =
    ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval $(dbus-launch --exit-with-session --sh-syntax)
      fi

      systemctl --user import-environment DISPLAY XAUTHORITY
      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
      fi

      exec xmonad
    '';
}
