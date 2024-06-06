{ ... }:

{
  imports =
    [
      ../work/configuration.nix
      ../../system/pkgs/steam.nix
      ../../system/services/mullvad.nix
      ../../system/hardware-configuration.nix
      ../../system/hardware/nvidia.nix
      ../../system/virtualisation/virt.nix
    ];
}
