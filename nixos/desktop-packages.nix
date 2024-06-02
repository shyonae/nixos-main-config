{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Desktop apps
    telegram-desktop
    kitty
    floorp
    discord
    gparted
    obsidian
    bitwarden
    ];
}
