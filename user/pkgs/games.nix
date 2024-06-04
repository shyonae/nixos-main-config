{ pkgs, pkgs-stable, ... }:
{
  home.packages = with pkgs; [
    osu-lazer-bin
    clonehero
  ];
}
