{ lib, config, ... }:

{
  options = {
    flatpak.enable = lib.mkEnableOption "enables flatpaks";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;
  };

  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
