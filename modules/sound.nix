{ config, pkgs, lib, ... }:

{
  # Sound configurations
  sound.enable = false;

  security.rtkit.enable = true;   # Optional but recommended
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Low latency setup
    config.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
        "link.max-buffers" = 16;
        "log.level" = 2;
      };
    };

    # Bluetooth config
    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [ { "device.name" = "~bluez_card.*"; } ];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            "bluez5.msbc-support" = true;
          };
        };
      }
      {
        # Matches all cards
        matches = [
          { "node.name" = "~bluez_input.*"; }
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
          "node.pause-on-idle" = false;
        };
      }
    ];

    # Pulseaudio config
    config.pipewire-pulse = {
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.quantum" = 32; # controls minimum playback quant
            "pulse.min.req" = 32;     # controls minimum recording quant
            "pulse.min.frag" = 32;    # controls minimum fragment size
            "server.address" = [ "unix:native" ];
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    alsaUtils
  ];
}
