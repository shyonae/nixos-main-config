{ lib, config, userSettings, ... }:
{
  options = {
    adb.enable = lib.mkEnableOption "enables adb";
  };

  config = lib.mkIf config.adb.enable {
    programs.adb.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "adbusers" ];
  };
}
