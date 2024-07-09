{ lib, pkgs, pkgs-stable, userSettings, ... }:
{
  programs.home-manager.enable = true;
  # style
  stylixPkg.enable = true;
  # others
  customScripts.enable = true;
  git.enable = true;
  htop.enable = true;
  hyprland.enable = lib.mkDefault false; # IF SET TO TRUE, REMOVE DEFAULT AND DISABLE GNOME!
  kitty.enable = true;
  nixvim.enable = lib.mkDefault false; # NIXVIM BREAKS REGULARLY, JUST MANAGE NEOVIM CONFIG MAYBE?
  tmux.enable = true;
  vim.enable = true;
  zsh.enable = true;
  # pkgs
  homePkgsCore.enable = true;
}	
