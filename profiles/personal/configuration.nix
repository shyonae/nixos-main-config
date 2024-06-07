{ lib, ... }:

{
  imports =
    [
      ../work/configuration.nix
    ];

  hardware.opentabletdriver.enable = true;

  mullvad.enable = true;
  nvidia.enable = true;
  games.enable = true;
}
