{ pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../work/home.nix
    ../../user/pkgs/games.nix
  ];

  home.stateVersion = "23.05";
}
