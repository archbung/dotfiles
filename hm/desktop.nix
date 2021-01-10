{ config, pkgs, ... }:
let xmonad = import ../config/xmonad;
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

          xrandr --output DVI-D-0 --primary --rotate left --auto
          xrandr --output DisplayPort-0 --auto --right-of DVI-D-0

          exec xmonad
        '';
      target = ".xinitrc";
    };
  };

  fonts.fontconfig.enable = true;

  xsession.enable = true;
  xsession.windowManager.command = "${xmonad}/bin/xmonad";

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    opacityRule = [
      # "100:class_g = 'Firefox'"
      # "100:class_g = 'Vivaldi-stable'"
      "100:class_g = 'VirtualBox Machine'"
      # Art/image programs where we need fidelity
      "100:class_g = 'Gimp'"
      "100:class_g = 'Inkscape'"
      "100:class_g = 'aseprite'"
      "100:class_g = 'krita'"
      "100:class_g = 'feh'"
      "100:class_g = 'mpv'"
      "100:class_g = 'Rofi'"
      "100:class_g = 'Peek'"
      "99:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
    ];
    shadowExclude = [
      # Put shadows on notifications, the scratch popup and rofi only
      "! name~='(rofi|scratch|Dunst)$'"
    ];
    extraOptions =
      ''
        unredir-if-possible = true;
        glx-no-stencil = true;
      '';
  };

  services.redshift = {
    enable = true;
    latitude = "49.279530";
    longitude = "7.034970";
    extraOptions = [ "-v" "-m randr" ];
  };
}
