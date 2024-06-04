{ pkgs, pkgs-stable, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    fantasque-sans-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
  ];
}
