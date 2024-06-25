{ lib, config, pkgs, pkgs-stable, userSettings, ... }:
{
  options = {
    games.enable = lib.mkEnableOption "enables games";
  };

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
      clonehero
      ludusavi
      lutris
      protonup
      moonlight-qt
    ];

    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
    programs.java.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        # withPrimus = true;
        # withJava = true;
        extraPkgs = pkgs: with pkgs; [
          libkrb5
          keyutils
          # bumblebee
          # glxinfo
        ];
      };
    };

    # to use custom protonup versions
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${userSettings.username}/.steam/root/compatibilitytools.d";
    };
  };
}
