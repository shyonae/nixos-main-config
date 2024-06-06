{ lib, config, ... }:
{
  imports =
    [
      ./bluetooth.nix
      ./kernel.nix
      ./nvidia.nix
      ./printing.nix
      ./sound.nix
      ./systemd.nix
      ./time.nix
    ];
}
