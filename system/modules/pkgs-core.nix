{ lib, config, pkgs, pkgs-stable, systemSettings, ... }:
{
  options = {
    pkgsCore.enable = lib.mkEnableOption "core packages";
  };

  config = lib.mkIf config.pkgsCore.enable {
    environment.systemPackages = with pkgs; [
      hwinfo
      pipewire
      pamixer
      home-manager
      samba4Full
      nixpkgs-fmt
      cifs-utils
      vim
      neovim
      tree
      wget
      git
      htop
      unzip
      zsh
      lshw
      ffmpeg
    ];
  };
}
