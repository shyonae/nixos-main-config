{ config, lib, pkgs, pkgs-stable, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../../user/pkgs/floorp.nix
    ../../user/pkgs/git.nix
    ../../user/pkgs/htop.nix
    ../../user/pkgs/nixvim/nixvim.nix
    ../../user/pkgs/vim.nix
    ../../user/pkgs/zsh.nix
    ../../user/pkgs/kitty.nix
    ../../user/pkgs/tmux.nix
    ../../user/pkgs/ranger.nix

    ../../user/pkgs/home-manager-pkgs-desktop.nix
  ];

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = lib.mkForce userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
}	
