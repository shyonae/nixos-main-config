{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
let
  specificSystemSettings = {
    hostname = "homelabrd450";
    bootMode = "uefi";
    bootMountPath = "/boot";
    grubDevice = "";
  };
in
{
  imports =
    [
      (import ./homelab_default.nix { inherit specificSystemSettings; })
    ];

  networking.hostName = specificSystemSettings.hostname;
}
