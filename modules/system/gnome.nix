{ lib, config, ... }:

{
  options = {
    gnome.enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;
    };

    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };

    services.displayManager.defaultSession = "gnome-xorg";
  };
}
