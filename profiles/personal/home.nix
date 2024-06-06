{ pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../work/home.nix
    ../../user/pkgs/games.nix
  ];

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

  home.stateVersion = "23.05";
}
