{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
let
  specificSystemSettings = {
    hostname = "homelabmainhpsff";
  };
in
{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
      ./homelab_default.nix
    ];
}
