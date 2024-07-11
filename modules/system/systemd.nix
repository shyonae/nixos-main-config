{ lib, config, ... }:

{
  options = {
    systemd.enable = lib.mkEnableOption "enables systemd options";
  };

  config = lib.mkIf config.systemd.enable {
    services.journald.extraConfig = "SystemMaxUse=50M\nSystemMaxFiles=5";
    services.journald.rateLimitBurst = 500;
    services.journald.rateLimitInterval = "30s";
  };
}
