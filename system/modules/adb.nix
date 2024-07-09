{ lib, config, ... }:
{
  options = {
    adb.enable = lib.mkEnableOption "enables adb";
  };

  config = lib.mkIf config.adb.enable {
    programs.adb.enable = true;
  };
}
