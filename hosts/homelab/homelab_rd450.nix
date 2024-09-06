{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:
let
  specificSystemSettings = {
    hostname = "homelabd450";
  };
in
{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
      ./homelab_default.nix
    ];
}
