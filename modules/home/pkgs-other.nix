{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    homePkgsOther.enable = lib.mkEnableOption "home other packages";
  };

  config = lib.mkIf config.homePkgsOther.enable {
    home.packages = with pkgs; [
      telegram-desktop
      kitty
      vscode
      (discord.override {
        # remove any overrides that you don't want
        withOpenASAR = true;
        withVencord = true;
      })
      vesktop
      scrcpy
      obsidian
      bitwarden
      prusa-slicer
      media-downloader
    ];
  };
}
