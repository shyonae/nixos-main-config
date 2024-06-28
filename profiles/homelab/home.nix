{ config, lib, pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;
  # others
  git.enable = true;
  htop.enable = true;
  hyprland.enable = lib.mkDefault false; # IF SET TO TRUE, REMOVE DEFAULT AND DISABLE GNOME!
  nixvim.enable = lib.mkDefault false; # NIXVIM BREAKS REGULARLY, JUST MANAGE NEOVIM CONFIG MAYBE?
  vim.enable = true;
  zsh.enable = true;

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = lib.mkForce userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
    MOZ_ENABLE_WAYLAND = 0;
  };
}	
