{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    games.enable = lib.mkEnableOption "enables games";
  };

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      steam
      osu-lazer-bin
      clonehero
    ];

    hardware.opengl.driSupport32Bit = true;
    programs.steam.enable = true;
  };
}
