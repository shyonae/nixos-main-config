{ pkgs, lib, config, ... }:
{
  options = {
    pulseaudio.enable = lib.mkEnableOption "enables pulseaudio";
  };

  config = lib.mkIf config.pulseaudio.enable {

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    hardware.pulseaudio = {
      enable = true;
      support32Bit = true;
      extraConfig = "load-module module-combine-sink";
    };
  };
}

