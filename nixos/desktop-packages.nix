{ pkgs, pkgs-stable, ... }: {

  environment.systemPackages = with pkgs; [
    telegram-desktop
    kitty
    floorp
    discord
    gparted
    obsidian
    bitwarden
    clonehero
    osu-lazer-bin
  ];
}
