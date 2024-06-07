{ lib, config, pkgs, userSettings, ... }:
{
  options = {
    virtConfig.enable = lib.mkEnableOption "enables virt configs";
  };

  config = lib.mkIf config.virtConfig.enable {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
