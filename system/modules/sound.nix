{ lib, config, ... }:
{
  options = {
    sound.enable = lib.mkEnableOption "enables sound";
  };

  config = lib.mkIf config.sound.enable {
    hardware.pulseaudio.enable = false;
    sound.enable = true;

    # rtkit is optional but recommended
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      jack.enable = false;
    };
  };
}

