{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    printing.enable = lib.mkEnableOption "enables printing";
  };

  config = lib.mkIf config.printing.enable {
    services.printing.enable = true;
  };
}
