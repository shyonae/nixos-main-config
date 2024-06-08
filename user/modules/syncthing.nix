{ lib, config, userSettings, pkgs, ... }:
{
  options = {
    syncthing.enable = lib.mkEnableOption "enables syncthing";
  };

  config = lib.mkIf config.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      syncthing
    ];
  };
}
