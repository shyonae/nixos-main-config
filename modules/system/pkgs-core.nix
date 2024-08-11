{ lib, config, pkgs, pkgs-stable, ... }:
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
      gh #github cli
      htop
      unzip
      zsh
      lshw
      ffmpeg
      jq
      ventoy-full
    ];
  };
}
