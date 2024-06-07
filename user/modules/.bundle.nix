{ lib, config, ... }:
{
  imports =
    [
      ./git.nix
      ./htop.nix
      ./hyprland.nix
      ./kitty.nix
      ./nixvim.nix
      ./pkgs-core.nix
      ./pkgs-other.nix
      ./ranger.nix
      ./stylix.nix
      ./tmux.nix
      ./vim.nix
      ./virt.nix
      ./zsh.nix
    ];
}
