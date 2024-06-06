{ lib, ... }:

{
  imports =
    [
      ../work/configuration.nix
      ../../system/pkgs/games.nix
      ../../system/hardware/nvidia.nix
      ../../system/hardware-configuration.nix
    ];

    mullvad.enable = lib.mkDefault true;
}
