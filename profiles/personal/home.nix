{ pkgs, pkgs-stable, userSettings, ... }:
{
  imports = [
    ../work/home.nix
  ];

  homePkgsOther.enable = true;
}
