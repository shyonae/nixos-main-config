{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [
        ../../user/pkgs/git.nix
        ../../user/pkgs/htop.nix
        ../../user/pkgs/nixvim/nixvim.nix
        ../../user/pkgs/vim.nix
        ../../user/pkgs/zsh.nix
        ../../user/pkgs/tmux.nix
        ../../user/pkgs/ranger.nix
            ];

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };
}
