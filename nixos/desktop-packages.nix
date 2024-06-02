{ pkgs, pkgs-stable, ... }: {

    environment.systemPackages = 
            (with pkgs; [
                    telegram-desktop
                    kitty
                    floorp
                    discord
                    gparted
                    obsidian
                    bitwarden
            ])

            (with pkgs-stable; [
                    # stable packages here
            ]);
}
