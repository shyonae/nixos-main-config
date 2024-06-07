{ config, lib, pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;
  # style
  stylix.enable = true;
  # others
  git.enable = true;
  htop.enable = true;
  hyprland.enable = lib.mkDefault false; # IF SET TO TRUE, REMOVE DEFAULT AND DISABLE GNOME!
  kitty.enable = true;
  nixvim.enable = true;
  ranger.enable = true;
  tmux.enable = true;
  vim.enable = true;
  zsh.enable = true;
  # Could not detect a default hypervisor. Make sure the appropriate QEMU/KVM virtualization packages are installed to manage virtualization on this host.
  # A virtualization connection can be manually added via File->Add Connection 
  virtConfig.enable = true; # to avoid doing the above manually, set to true
  # pkgs
  homePkgsCore.enable = true;

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = lib.mkForce userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
}	
