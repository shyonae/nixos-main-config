{ lib, config, ... }:
{
  imports =
    [
      ./custom-scripts.nix
      ./git.nix
      ./htop.nix
      ./hyprland.nix
      ./kitty.nix
      ./nixvim.nix
      ./pkgs-core.nix
      ./pkgs-other.nix
      ./stylix.nix
      ./syncthing.nix
      ./tmux.nix
      ./vim.nix
      ./virt.nix
      ./zsh.nix
    ];
}
