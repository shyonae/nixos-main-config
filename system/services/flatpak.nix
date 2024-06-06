{ ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

