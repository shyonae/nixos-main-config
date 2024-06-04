{ pkgs, pkgs-stable, ... }:
{
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
}	
