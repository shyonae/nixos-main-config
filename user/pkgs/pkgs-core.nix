{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    home-manager
    samba4Full
    lazygit
    nixpkgs-fmt
    cifs-utils
    vim neovim
    tree
    wget
    git
    fastfetch
    htop
    unzip
    zsh
  ];
}
