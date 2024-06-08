{ pkgs, pkgs-stable, userSettings, ... }:
{
  imports = [
    ../work/home.nix
  ];

  homePkgsOther.enable = true;
  customScripts.enable = true;
  syncthing.enable = true;
}
