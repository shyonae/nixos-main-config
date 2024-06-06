{ lib, ... }:

{
  imports =
    [
      ../work/configuration.nix
    ];

  mullvad.enable = true;
  nvidia.enable = true;
  games.enable = true;
}
