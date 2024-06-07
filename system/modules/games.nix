{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    games.enable = lib.mkEnableOption "enables games";
  };

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
      clonehero
    ];

    programs.gamescope.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          libkrb5
          keyutils
        ];
      };
    };
  };
}
