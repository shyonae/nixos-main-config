{ lib, config, ... }:
{
  imports =
    [
      ./git.nix
      ./htop.nix
      ./hyprland.nix
      ./kitty.nix
      ./nixvim.nix
      ./ranger.nix
      ./tmux.nix
      ./vim.nix
      ./zsh.nix
      ./pkgs-core.nix
      ./pkgs-other.nix
    ];
}
