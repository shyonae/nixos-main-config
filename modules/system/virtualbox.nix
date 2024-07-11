{ lib, config, pkgs, ... }:
{
  options = {
    virtualbox.enable = lib.mkEnableOption "enables virtualbox";
  };

  config = lib.mkIf config.virtualbox.enable {

    virtualisation.virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;

      guest.enable = true;
    };
  };
}
