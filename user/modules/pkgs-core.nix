{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    homePkgsCore.enable = lib.mkEnableOption "home core packages";
  };

  config = lib.mkIf config.homePkgsCore.enable {
    home.packages = with pkgs; [
      # desktop apps
      gparted
      libreoffice-fresh

      # other
      wine
      tmux
      lazygit
      yt-dlp
      fastfetch
    ];
  };
}
