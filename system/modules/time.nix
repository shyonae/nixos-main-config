{ lib, config, ... }:
{
  options = {
    timesyncd.enable = lib.mkEnableOption "enables timesyncd";
  };

  config = lib.mkIf config.timesyncd.enable {
    services.timesyncd.enable = true;
  };
}
