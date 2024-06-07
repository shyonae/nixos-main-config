{ lib, config, ... }:
{
  imports =
    [
      ./bluetooth.nix
      ./firewall.nix
      ./flatpak.nix
      ./games.nix
      ./garbage-collect.nix
      ./gnome.nix
      ./kernel.nix
      ./mullvad.nix
      ./nvidia.nix
      ./pipewire.nix
      ./printing.nix
      ./pkgs-core.nix
      ./pkgs-other.nix
      ./proxy.nix
      ./samba.nix
      ./ssh.nix
      ./systemd.nix
      ./time.nix
      ./virt.nix
      ./virtualbox.nix
      ./xdg.nix
    ];
}
