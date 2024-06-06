{ services, pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
  services.xserver = {
    # Enable Gnome
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.displayManager.defaultSession = "gnome";
}
