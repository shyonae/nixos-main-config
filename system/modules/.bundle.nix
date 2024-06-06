{ lib, config, ... }:
{
  imports =
    [
      ./bluetooth.nix
      ./firewall.nix
      ./flatpak.nix
      ./fonts.nix
      ./games.nix
      ./garbage-collect.nix
      ./gnome.nix
      ./kernel.nix
      ./mullvad.nix
      ./nvidia.nix
      ./printing.nix
      ./proxy.nix
      ./ssh.nix
      ./samba.nix
      ./systemd.nix
      ./time.nix
      ./virt.nix
      ./xdg.nix
      ./pkgs-core.nix
      ./pkgs-other.nix
    ];
}
