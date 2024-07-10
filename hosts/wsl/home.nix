{ config, lib, pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  customScripts.enable = true;
  git.enable = true;
  htop.enable = true;
  tmux.enable = true;
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
