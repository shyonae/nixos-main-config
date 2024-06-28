{ config, lib, pkgs, pkgs-stable, userSettings, ... }:
{
  imports = [
    ../work/home.nix
  ];

  stylixPkg.enable = lib.mkDefault false;
  virtConfig.enable = lib.mkDefault false;
}	
