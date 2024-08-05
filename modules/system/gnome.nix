{ lib, config, pkgs, ... }:

{
  options = {
    gnome.enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };

      xkb.layout = "us";
      xkb.variant = "";

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;
    };

    services.xrdp.defaultWindowManager = "gnome-remote-desktop";
    services.xrdp.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.gnome-remote-desktop
      gnomeExtensions.awesome-tiles
    ];

    services.displayManager.defaultSession = "gnome-xorg";
  };
}
