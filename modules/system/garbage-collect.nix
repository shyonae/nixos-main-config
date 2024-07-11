{ lib, config, ... }:
{
  options = {
    garbageCollect.enable = lib.mkEnableOption "enables garbage collection";
  };

  config = lib.mkIf config.garbageCollect.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
