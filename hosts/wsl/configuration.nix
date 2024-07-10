{ lib, config, pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
wsl = {
  enable = true;
  wslConf.automount.root = "/mnt";
  wslConf.interop.appendWindowsPath = false;
  wslConf.network.generateHosts = false;
  defaultUser = userSettings.username;
  startMenuLaunchers = true;

  # Enable integration with Docker Desktop (needs to be installed)
  docker-desktop.enable = false;
};

virtualisation.docker = {
  enable = true;
  enableOnBoot = true;
  autoPrune.enable = true;
};

nix = {
  settings = {
    trusted-users = [userSettings.username];
    accept-flake-config = true;
    auto-optimise-store = true;
  };

  nixPath = [
    "nixpkgs=${inputs.nixpkgs.outPath}"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ]; 

  gnome.enable = lib.mkDefault false;
  bluetooth.enable = true;
  firewall.enable = true;
  garbageCollect.enable = true;
  docker.enable = true;
  nfs.enable = true;
  samba.enable = true;
  ssh.enable = true;
  timesyncd.enable = true;
  virt.enable = true;
  pkgsCore.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
    lazygit
    fastfetch
  ];

  # for nix-index-database
  programs.command-not-found.enable = false;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  programs.zsh.enable = true;

  # User account
  users = {
    defaultUserShell = pkgs.zsh;

    users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.description;
      extraGroups = [ "networkmanager" "wheel" "input" "dialout" "audio" ];
      uid = 1000;
    };
  };

  services.getty.autologinUser = userSettings.username;

  # if plugged in, closing the laptop lid doesn't suspend
  services.logind.lidSwitchExternalPower = "ignore";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
