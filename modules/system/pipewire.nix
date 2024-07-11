{ lib, config, ... }:
{
  options = {
    pipewire.enable = lib.mkEnableOption "enables pipewire";
  };

  config = lib.mkIf config.pipewire.enable {

    # has to be set to avoid conflicts
    hardware.pulseaudio.enable = false;

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
  };
}

