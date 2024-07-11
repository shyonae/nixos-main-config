{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    nfs.enable = lib.mkEnableOption "enables nfs";
  };

  config = lib.mkIf config.nfs.enable {
    services.nfs.server.enable = true;
  };
}
