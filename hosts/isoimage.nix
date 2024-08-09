{ config, lib, pkgs, pkgs-stable, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  environment.systemPackages = with pkgs; [
    hwinfo
    samba4Full
    cifs-utils
    vim
    neovim
    tree
    wget
    git
    htop
    unzip
    lshw
    jq
    disko
    parted
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # nix build $HOME/nix#nixosConfigurations.homelabIso.config.system.build.isoImage

  # nix run nixpkgs#nixos-generators -- --format iso --flake $HOME/nix#homelabIso -o homelab.iso
}
