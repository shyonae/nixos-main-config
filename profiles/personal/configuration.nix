{ lib, ... }:

{
  imports =
    [
      ../work/configuration.nix
    ];

  hardware.opentabletdriver.enable = true;

  mullvad.enable = true;
  nvidia.enable = true;
  # waydroid.enable = true;
  nixLd.enable = true;
  docker.enable = true;
  games.enable = true;
}
