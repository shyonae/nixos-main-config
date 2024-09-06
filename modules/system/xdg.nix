{ lib, config, pkgs, pkgs-stable, ... }:
{

  options = {
    xdg.enable = lib.mkEnableOption "enables xdg";
  };

  config = lib.mkIf config.xdg.enable {
    xdg = {
      portal.enable = true;
      # portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      portal.config.common.default = "*";
    };
  };

}
