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
      ranger
      discord
      obsidian
      bitwarden
      syncthing
    ];
  };
}
