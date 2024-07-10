{ lib, config, pkgs, pkgs-stable, ... }:
{
  # style
  gnome.enable = true;
  # services
  bluetooth.enable = true;
  firewall.enable = true;
  garbageCollect.enable = true;
  pipewire.enable = true;
  pulseaudio.enable = lib.mkDefault false;
  timesyncd.enable = true;
  # pkgs
  pkgsCore.enable = true;

  # for nix-index-database
  programs.command-not-found.enable = false;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # if plugged in, closing the laptop lid doesn't suspend
  services.logind.lidSwitchExternalPower = "ignore";

  system.stateVersion = "23.05"; # Did you read the comment?
}
