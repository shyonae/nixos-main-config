{ lib, config, ... }:
{
  imports =
    [
      ../../system/services/firewall.nix
      ../../system/services/flatpak.nix
      ../../system/services/garbage-collect.nix
      ../../system/services/proxy.nix
      ../../system/services/samba.nix
      ../../system/services/ssh.nix
      ../../system/services/xdg.nix
      ../../system/services/mullvad.nix
    ];
}
