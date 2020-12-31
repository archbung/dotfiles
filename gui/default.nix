{ config, pkgs, ... }:
let dwm = pkgs.dwm.overrideAttrs (oldAttrs: {
      patches = [ ];
      configurePhase =
        ''
        cp ${./dwm/config.h} config.h
        '';
    });
    xmonad = import ./xmonad;
in
{
  home = {
    packages = with pkgs; [
      dmenu
      xclip
      pulsemixer
      i3lock
      xmonad
    ];

    file.xinitrc = {
      text =
        ''
          if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
            eval $(dbus-launch --exit-with-session --sh-syntax)
          fi
          systemctl --user import-environment DISPLAY XAUTHORITY

          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
            dbus-update-activation-environment DISPLAY XAUTHORITY
          fi

          xrandr --output DVI-D-0 --primary --orientation left --auto
          xrandr --output DisplayPort-0 --auto --right-of DVI-D-0

          exec xmonad
        '';
      target = ".xinitrc";
    };
  };

  fonts.fontconfig.enable = true;

  xsession.enable = true;
  xsession.windowManager.command = "${xmonad}/bin/xmonad";

  services.redshift = {
    enable = true;
    latitude = "49.279530";
    longitude = "7.034970";
    extraOptions = [ "-v" "-m randr" ];
  };
}
