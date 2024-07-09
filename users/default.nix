{ lib, pkgs, pkgs-stable, userSettings, ... }:
{
  programs.home-manager.enable = true;
  # style
  stylixPkg.enable = true;
  # others
  git.enable = true;
  htop.enable = true;
  hyprland.enable = lib.mkDefault false; # IF SET TO TRUE, REMOVE DEFAULT AND DISABLE GNOME!
  kitty.enable = true;
  tmux.enable = true;
  vim.enable = true;
  zsh.enable = true;
  # pkgs
  homePkgsCore.enable = true;
}	
