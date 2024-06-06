{ ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

