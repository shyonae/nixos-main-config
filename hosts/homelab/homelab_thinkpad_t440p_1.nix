{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
let
  specificSystemSettings = {
    hostname = "homelabthinkpadt440p1";
    bootMode = "grub";
    bootMountPath = "";
    grubDevice = "/dev/sda";
  };
in
{
  imports =
    [
      (import ./homelab_default.nix { inherit specificSystemSettings; })
    ];

  networking.hostName = specificSystemSettings.hostname;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
