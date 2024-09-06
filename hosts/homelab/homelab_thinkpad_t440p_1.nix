{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
let
  specificSystemSettings = {
    hostname = "homelabthinkpadt440p1";
  };
in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./homelab_default.nix
    ];

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
